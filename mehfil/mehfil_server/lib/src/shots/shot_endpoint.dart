import 'dart:isolate';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;
import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../generated/protocol.dart';
import '../reveal/reveal_service.dart';
import '../wall/wall_service.dart';

/// Receives photos from the phone's queue. A shot counts as delivered only
/// when its file is in private storage, its hash matched, and its receipt row
/// is written. Retries are safe: the same shot id is stored once.
class ShotEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const storageId = 'private';
  static const maxBytes = 6 * 1024 * 1024;

  Future<ShotAck> upload(
    Session session, {
    required UuidValue shotId,
    required int rollId,
    required DateTime takenAt,
    required String sha256Hex,
    required ByteData bytes,
  }) async {
    final roll = await Access.roll(session, rollId);
    final guest = await Access.guestOf(session, roll.eventId);
    if (guest == null) {
      throw MehfilException(
        code: 'not_joined',
        message: 'Join the event before sending photos.',
      );
    }

    final existing = await ShotReceipt.db.findFirstRow(
      session,
      where: (t) => t.shotId.equals(shotId),
    );
    if (existing != null) {
      if (existing.guestId != guest.id) {
        throw MehfilException(code: 'conflict', message: 'Shot id in use.');
      }
      return ShotAck(
        shotId: shotId,
        receivedAt: existing.receivedAt,
        duplicate: true,
      );
    }

    final data = bytes.buffer.asUint8List(
      bytes.offsetInBytes,
      bytes.lengthInBytes,
    );
    if (data.isEmpty || data.length > maxBytes) {
      throw MehfilException(code: 'too_large', message: 'Photo is too large.');
    }
    final actual = sha256.convert(data).toString();
    if (actual != sha256Hex.toLowerCase()) {
      // The bytes were damaged on the way. The phone keeps the shot and retries.
      throw MehfilException(
        code: 'hash_mismatch',
        message: 'The photo arrived damaged. It will be sent again.',
      );
    }

    final processed = await Isolate.run(() => _process(data));
    if (processed == null) {
      throw MehfilException(code: 'not_image', message: 'Not a photo.');
    }

    final base = 'events/${roll.eventId}/rolls/$rollId';
    final storagePath = '$base/$shotId.jpg';
    final thumbPath = '$base/thumbs/$shotId.jpg';
    await session.storage.storeFile(
      storageId: storageId,
      path: storagePath,
      byteData: bytes,
    );
    await session.storage.storeFile(
      storageId: storageId,
      path: thumbPath,
      byteData: ByteData.sublistView(processed.thumb),
    );

    final receivedAt = DateTime.now().toUtc();
    try {
      await ShotReceipt.db.insertRow(
        session,
        ShotReceipt(
          shotId: shotId,
          eventId: roll.eventId,
          rollId: rollId,
          guestId: guest.id!,
          storagePath: storagePath,
          thumbPath: thumbPath,
          sha256: actual,
          sizeBytes: data.length,
          width: processed.width,
          height: processed.height,
          takenAt: takenAt.toUtc(),
          receivedAt: receivedAt,
        ),
      );
    } on DatabaseQueryException {
      // Two copies of one shot raced (same phone, two tabs). One receipt wins.
      final winner = await ShotReceipt.db.findFirstRow(
        session,
        where: (t) => t.shotId.equals(shotId),
      );
      if (winner == null) rethrow;
      return ShotAck(
        shotId: shotId,
        receivedAt: winner.receivedAt,
        duplicate: true,
      );
    }

    if (roll.revealedAt != null) {
      // A late photo of an open roll joins the album straight away.
      final event = await Access.eventById(session, roll.eventId);
      await RevealService.publish(session, event, roll);
    }
    await WallService.tick(session, roll.eventId, 'photo');
    return ShotAck(shotId: shotId, receivedAt: receivedAt, duplicate: false);
  }
}

typedef _Processed = ({int width, int height, Uint8List thumb});

_Processed? _process(Uint8List data) {
  final image = img.decodeImage(data);
  if (image == null) return null;
  final oriented = img.bakeOrientation(image);
  final thumb = img.copyResize(
    oriented,
    width: oriented.width >= oriented.height ? 480 : null,
    height: oriented.width < oriented.height ? 480 : null,
    interpolation: img.Interpolation.average,
  );
  return (
    width: oriented.width,
    height: oriented.height,
    thumb: img.encodeJpg(thumb, quality: 72),
  );
}
