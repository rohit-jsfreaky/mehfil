import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;
import 'package:mehfil_server/src/generated/protocol.dart';
import 'package:mehfil_server/src/reveal/reveal_service.dart';
import 'package:serverpod_offline_sync_server/serverpod_offline_sync_server.dart'
    show
        OfflineSyncInitialize,
        OfflineSyncSpaceMembership,
        OfflineSyncSpaceRole,
        offlineSyncDatabaseInterceptor;
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import 'test_tools/serverpod_test_tools.dart';

const hostId = '018f0000-0000-7000-8000-000000000001';
const bua = '018f0000-0000-7000-8000-000000000002';
const chachu = '018f0000-0000-7000-8000-000000000003';
const stranger = '018f0000-0000-7000-8000-000000000004';

/// A real JPEG, so the server's decode and thumbnail run for real.
ByteData jpeg(int seed) {
  final image = img.Image(width: 1200, height: 900);
  img.fill(image, color: img.ColorRgb8(seed * 40 % 255, 120, 60));
  return ByteData.sublistView(img.encodeJpg(image, quality: 80));
}

String hashOf(ByteData bytes) => sha256
    .convert(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes))
    .toString();

void main() {
  withServerpod(
    'Given an event with one roll that reveals tomorrow',
    rollbackDatabase: RollbackDatabase.disabled,
    // The test pod is not the generated Serverpod class, so offline sync is
    // wired here the way the generated class wires it in production.
    databaseInterceptor: offlineSyncDatabaseInterceptor,
    (sessionBuilder, endpoints) {
      sessionBuilder.build().serverpod.initializeOfflineSync(
        syncTables: syncTables,
      );
      TestSessionBuilder as(String userId) => sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userId, {}),
      );

      late HostEvent created;
      late int rollId;
      late String code;

      Future<ShotAck> send(String user, UuidValue shotId, ByteData bytes) {
        return endpoints.shot.upload(
          as(user),
          shotId: shotId,
          rollId: rollId,
          takenAt: DateTime.now(),
          sha256Hex: hashOf(bytes),
          bytes: bytes,
        );
      }

      setUpAll(() async {
        created = await endpoints.events.createEvent(
          as(hostId),
          'Riya & Arjun',
          [
            RollDraft(
              name: 'Sangeet',
              revealAt: DateTime.now().add(const Duration(days: 1)),
            ),
          ],
          isDemo: true,
          hostedBy: 'the Sharma family',
        );
        rollId = created.rolls.single.id!;
        code = created.event.joinCode;
        await endpoints.guest.join(as(bua), code, 'Bua');
        await endpoints.guest.join(as(chachu), code, 'Chachu');
      });

      test(
        'then the event gets a 6-letter join code and its roll is hidden',
        () {
          expect(code, hasLength(6));
          expect(created.rolls.single.revealedAt, isNull);
        },
      );

      test(
        'when a guest uploads a photo then the server stores it once',
        () async {
          final shot = UuidValue.fromString(const Uuid().v7());
          final bytes = jpeg(1);
          final first = await send(bua, shot, bytes);
          final retry = await send(bua, shot, bytes);

          expect(first.duplicate, isFalse);
          expect(retry.duplicate, isTrue);
          expect(retry.receivedAt, first.receivedAt);
          final session = sessionBuilder.build();
          final receipts = await ShotReceipt.db.find(
            session,
            where: (t) => t.shotId.equals(shot),
          );
          expect(receipts, hasLength(1));
          expect(receipts.single.width, 1200);
        },
      );

      test(
        'when the bytes are damaged on the way then the upload is refused',
        () async {
          final bytes = jpeg(2);
          await expectLater(
            endpoints.shot.upload(
              as(bua),
              shotId: UuidValue.fromString(const Uuid().v7()),
              rollId: rollId,
              takenAt: DateTime.now(),
              sha256Hex: hashOf(jpeg(3)),
              bytes: bytes,
            ),
            throwsA(
              isA<MehfilException>().having(
                (e) => e.code,
                'code',
                'hash_mismatch',
              ),
            ),
          );
        },
      );

      test(
        'when someone who did not join uploads then it is refused',
        () async {
          final bytes = jpeg(4);
          await expectLater(
            send(stranger, UuidValue.fromString(const Uuid().v7()), bytes),
            throwsA(
              isA<MehfilException>().having(
                (e) => e.code,
                'code',
                'not_joined',
              ),
            ),
          );
        },
      );

      test('when a judge asks for a hidden sample on a demo event then they get an id, not a photo', () async {
        await send(bua, UuidValue.fromString(const Uuid().v7()), jpeg(7));
        final sample = await endpoints.judge.hiddenSample(as(stranger), code);
        expect(sample, isNotNull);
        await expectLater(
          endpoints.album.photo(as(stranger), sample!.shotId, thumb: false),
          throwsA(isA<MehfilException>()),
        );
      });

      test('when the event is not a demo then the judge page refuses', () async {
        final real = await endpoints.events.createEvent(
          as(hostId),
          'A real wedding',
          [RollDraft(name: 'Shaadi', revealAt: DateTime.now().add(const Duration(days: 1)))],
          isDemo: false,
          hostedBy: null,
        );
        await expectLater(
          endpoints.judge.hiddenSample(as(stranger), real.event.joinCode),
          throwsA(isA<MehfilException>().having((e) => e.code, 'code', 'not_demo')),
        );
      });

      group('before the reveal', () {
        late UuidValue buaShot;

        setUpAll(() async {
          buaShot = UuidValue.fromString(const Uuid().v7());
          await send(bua, buaShot, jpeg(5));
        });

        test('then another guest cannot fetch the photo', () async {
          await expectLater(
            endpoints.album.photo(as(chachu), buaShot, thumb: true),
            throwsA(
              isA<MehfilException>().having((e) => e.code, 'code', 'hidden'),
            ),
          );
        });

        test(
          'then even the guest who took it cannot fetch it from the server',
          () async {
            await expectLater(
              endpoints.album.photo(as(bua), buaShot, thumb: false),
              throwsA(isA<MehfilException>()),
            );
          },
        );

        test('then even the host cannot fetch it', () async {
          await expectLater(
            endpoints.album.photo(as(hostId), buaShot, thumb: true),
            throwsA(isA<MehfilException>()),
          );
        });

        test('then the wall shows counts only', () async {
          final wall = await endpoints.wall.snapshot(as(chachu), code);
          expect(wall.photos, greaterThanOrEqualTo(2));
          expect(wall.guests, 2);
          expect(wall.rolls.single.revealedAt, isNull);
        });

        test('then a guest is not a member of the album space', () async {
          final session = sessionBuilder.build();
          final role = await OfflineSyncSpaceMembership.roleOf(
            session,
            userUuid: UuidValue.fromString(chachu),
            spaceUuid: created.event.albumSpaceId,
          );
          expect(role, isNull);
        });
      });

      group('when the reveal runs twice (schedule + host, or a restart)', () {
        late bool first;
        late bool second;

        setUpAll(() async {
          final session = sessionBuilder.build();
          first = await RevealService.reveal(
            session,
            rollId,
            trigger: 'schedule',
          );
          second = await RevealService.reveal(session, rollId, trigger: 'host');
        });

        test(
          'then only the first call reveals, and one log row exists',
          () async {
            expect(first, isTrue);
            expect(second, isFalse);
            final session = sessionBuilder.build();
            final logs = await RevealLog.db.find(
              session,
              where: (t) => t.rollId.equals(rollId),
            );
            expect(logs, hasLength(1));
            expect(logs.single.trigger, 'schedule');
          },
        );

        test('then every received photo is in the album space, once', () async {
          final session = sessionBuilder.build();
          final receipts = await ShotReceipt.db.count(
            session,
            where: (t) => t.rollId.equals(rollId),
          );
          final album = await AlbumPhoto.db.count(
            session,
            where: (t) => t.rollId.equals(rollId),
          );
          expect(album, receipts);
        });

        test('then guests are read-only members of the album space', () async {
          final session = sessionBuilder.build();
          final role = await OfflineSyncSpaceMembership.roleOf(
            session,
            userUuid: UuidValue.fromString(chachu),
            spaceUuid: created.event.albumSpaceId,
          );
          expect(role, OfflineSyncSpaceRole.readOnly);
        });

        test('then another guest can now fetch the photo', () async {
          final session = sessionBuilder.build();
          final any = await ShotReceipt.db.findFirstRow(
            session,
            where: (t) => t.rollId.equals(rollId),
          );
          final bytes = await endpoints.album.photo(
            as(chachu),
            any!.shotId,
            thumb: true,
          );
          expect(bytes.lengthInBytes, greaterThan(1000));
        });

        test('then a stranger still cannot fetch it', () async {
          final session = sessionBuilder.build();
          final any = await ShotReceipt.db.findFirstRow(
            session,
            where: (t) => t.rollId.equals(rollId),
          );
          await expectLater(
            endpoints.album.photo(as(stranger), any!.shotId, thumb: true),
            throwsA(isA<MehfilException>()),
          );
        });

        test('then the wall lists who sent photos, names and counts only', () async {
          final wall = await endpoints.wall.snapshot(as(chachu), code);
          expect(wall.activity, isNotEmpty);
          expect(
            wall.activity.where((a) => a.kind == 'photos').map((a) => a.name),
            contains('Bua'),
          );
        });

        test('then the host sees the album and can remove a photo for everyone', () async {
          final before = await endpoints.events.album(as(hostId), created.event.id!);
          expect(before, isNotEmpty);
          final target = before.first.shotId;

          await expectLater(
            endpoints.events.removePhoto(as(chachu), target),
            throwsA(isA<MehfilException>()),
          );
          await endpoints.events.removePhoto(as(hostId), target);

          final after = await endpoints.events.album(as(hostId), created.event.id!);
          expect(after.map((p) => p.shotId), isNot(contains(target)));
          await expectLater(
            endpoints.album.photo(as(chachu), target, thumb: true),
            throwsA(isA<MehfilException>()),
          );
          final session = sessionBuilder.build();
          final inAlbumSpace = await AlbumPhoto.db.count(
            session,
            where: (t) => t.shotId.equals(target),
          );
          expect(inAlbumSpace, 0);
          final receipt = await ShotReceipt.db.findFirstRow(
            session,
            where: (t) => t.shotId.equals(target),
          );
          expect(receipt!.removedAt, isNotNull, reason: 'evidence that it arrived stays');
        });

        test('then a late photo joins the album straight away', () async {
          final late = UuidValue.fromString(const Uuid().v7());
          await send(chachu, late, jpeg(9));
          final session = sessionBuilder.build();
          final album = await AlbumPhoto.db.count(
            session,
            where: (t) => t.shotId.equals(late),
          );
          expect(album, 1);
        });
      });
    },
  );
}
