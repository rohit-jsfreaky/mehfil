// "Try to break it": attacks the hiding rule against a RUNNING server, the way
// a curious guest would. Every attack must fail before the reveal; after the
// reveal, members get the album and strangers still get nothing.
//
//   dart run mehfil_tools:attacks --server http://localhost:8080/
//
// Writes evidence/proofs/attacks-<time>.json and prints one PASS/FAIL line each.
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'package:mehfil_tools/mehfil_tools.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';

final results = <Map<String, Object?>>[];

void check(String claim, bool pass, [String detail = '']) {
  results.add({'claim': claim, 'pass': pass, 'detail': detail});
  stdout.writeln(
    '${pass ? 'PASS' : 'FAIL'}  $claim${detail.isEmpty ? '' : '  ($detail)'}',
  );
}

Future<bool> fails(Future<Object?> Function() attempt) async {
  try {
    await attempt();
    return false;
  } catch (_) {
    return true;
  }
}

Future<OfflineSyncDatabaseSession> syncSession(
  Client client,
  UuidValue user,
  Directory dir,
) {
  return client.createSyncSession(
    '${dir.path}/${user.uuid}.db',
    isDebugMode: false,
    persistentUserId: user,
  );
}

Future<void> main(List<String> argv) async {
  final args =
      (ArgParser()
            ..addOption('server', defaultsTo: 'http://localhost:8080/')
            ..addOption('email', defaultsTo: 'proof-host@mehfil.dev')
            ..addOption('password', defaultsTo: 'proof-host-password-1')
            ..addOption('evidence', defaultsTo: '../../evidence/proofs'))
          .parse(argv);
  final server = args['server'] as String;
  final tmp = Directory.systemTemp.createTempSync('mehfil-attacks-');

  // Setup: a demo event whose roll opens tomorrow; two guests.
  final host = connect(server);
  await signInHost(
    host,
    email: args['email'] as String,
    password: args['password'] as String,
  );
  final now = await host.guest.now();
  final event = await host.events.createEvent('Attack test (demo)', [
    RollDraft(name: 'Sangeet', revealAt: now.add(const Duration(days: 1))),
  ], isDemo: true);
  final code = event.event.joinCode;
  final rollId = event.rolls.single.id!;

  final a = connect(server);
  final joinA = await joinAsGuest(a, code, 'Guest A');
  final b = connect(server);
  final joinB = await joinAsGuest(b, code, 'Guest B');

  // Guest A shoots the way the app does: the row through offline sync, the file
  // through the upload endpoint.
  final localA = await syncSession(a, joinA.guest.authUserId, tmp);
  final shotIds = <UuidValue>[];
  for (var i = 0; i < 2; i++) {
    final bytes = testJpeg(100 + i);
    final id = newShotId();
    await Shot.db.insertRow(
      localA,
      Shot(
        id: id,
        eventId: event.event.id!,
        rollId: rollId,
        guestName: 'Guest A',
        takenAt: DateTime.now().toUtc(),
        sha256: sha256Of(bytes),
        width: 0,
        height: 0,
        sizeBytes: bytes.lengthInBytes,
      ),
    );
    await uploadShot(a, rollId: rollId, bytes: bytes, shotId: id);
    shotIds.add(id);
  }
  await a.offlineSync.syncOnce(localA);

  // 1. A made-up QR code cannot even get a guest session.
  check(
    'A made-up join code cannot sign in',
    await fails(() => connect(server).anonymousIdp.login(token: 'ZZZZZZ')),
  );

  // 2. Guest B asks the server for A's photo (B even knows the shot id).
  check(
    "Before the reveal, another guest cannot fetch a guest's photo",
    await fails(() => b.album.photo(shotIds.first, thumb: true)) &&
        await fails(() => b.album.photo(shotIds.first, thumb: false)),
  );
  check(
    'Before the reveal, even the host cannot fetch it',
    await fails(() => host.album.photo(shotIds.first, thumb: true)),
  );

  // 3. Guessing a storage URL: the files are in private storage, so the
  //    public file route has nothing to give.
  final guess = Uri.parse(server).resolve(
    'serverpod_cloud_storage?method=file&path=events/${event.event.id}/rolls/$rollId/${shotIds.first.uuid}.jpg',
  );
  final guessed = await http.get(guess);
  check(
    'A guessed storage URL returns no photo',
    guessed.statusCode != 200 ||
        !(guessed.headers['content-type'] ?? '').contains('image'),
    'HTTP ${guessed.statusCode}',
  );

  // 4. Guest B runs real offline sync: A's rows must not come down.
  final localB = await syncSession(b, joinB.guest.authUserId, tmp);
  await b.offlineSync.syncOnce(localB);
  final bShots = await Shot.db.count(localB);
  final bAlbum = await AlbumPhoto.db.count(localB);
  check(
    "Before the reveal, offline sync gives guest B none of A's rows",
    bShots == 0 && bAlbum == 0,
    'B sees $bShots shot rows, $bAlbum album rows',
  );

  // 5. The wall carries counts only.
  final wall = await b.wall.snapshot(code);
  check(
    'The wall shows the count but no photo',
    wall.photos == 2,
    'photos=${wall.photos}',
  );

  // The reveal.
  await host.events.revealNow(rollId);
  await b.offlineSync.syncOnce(localB);
  final bAlbumAfter = await AlbumPhoto.db.count(localB);
  final bShotsAfter = await Shot.db.count(localB);
  check(
    'After the reveal, offline sync brings guest B the album',
    bAlbumAfter == 2,
    'B sees $bAlbumAfter album rows',
  );
  check(
    "After the reveal, A's private shot rows still stay with A",
    bShotsAfter == 0,
    'B sees $bShotsAfter shot rows',
  );
  final photo = await b.album.photo(shotIds.first, thumb: true);
  check(
    'After the reveal, a guest can open the photo',
    photo.lengthInBytes > 1000,
    '${photo.lengthInBytes} bytes',
  );

  // A stranger who joins another event still gets nothing.
  final otherEvent = await host.events.createEvent('Other event (demo)', [
    RollDraft(name: 'Dinner', revealAt: now.add(const Duration(days: 1))),
  ], isDemo: true);
  final stranger = connect(server);
  await joinAsGuest(stranger, otherEvent.event.joinCode, 'Stranger');
  check(
    'After the reveal, a guest of another event still cannot fetch it',
    await fails(() => stranger.album.photo(shotIds.first, thumb: true)),
  );

  await localA.close();
  await localB.close();
  final dir = Directory(args['evidence'] as String)
    ..createSync(recursive: true);
  final out = File(
    '${dir.path}/attacks-${DateTime.now().toUtc().millisecondsSinceEpoch}.json',
  );
  final passed = results.where((r) => r['pass'] == true).length;
  out.writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert({
      'server': server,
      'eventId': event.event.id,
      'ranAt': DateTime.now().toUtc().toIso8601String(),
      'passed': passed,
      'total': results.length,
      'results': results,
    }),
  );
  stdout.writeln('$passed/${results.length} attacks held → ${out.path}');
  exit(passed == results.length ? 0 : 1);
}
