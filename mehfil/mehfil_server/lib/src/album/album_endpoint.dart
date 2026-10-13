import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../generated/protocol.dart';
import '../shots/shot_endpoint.dart';

/// Serves photo files, and only after their roll is revealed, and only to the
/// event's guests and host. Photos live in private storage, so there is no
/// URL to guess before this check passes.
class AlbumEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<ByteData> photo(
    Session session,
    UuidValue shotId, {
    required bool thumb,
  }) async {
    final receipt = await ShotReceipt.db.findFirstRow(
      session,
      where: (t) => t.shotId.equals(shotId),
    );
    if (receipt == null || receipt.removedAt != null) throw _hidden();

    final roll = await Access.roll(session, receipt.rollId);
    if (roll.revealedAt == null) throw _hidden();

    final event = await Access.eventById(session, roll.eventId);
    final isHost = event.hostUserId == Access.userId(session);
    if (!isHost && await Access.guestOf(session, event.id!) == null) {
      throw _hidden();
    }

    return session.storage.retrieveFile(
      storageId: ShotEndpoint.storageId,
      path: thumb ? receipt.thumbPath : receipt.storagePath,
    );
  }

  /// One answer for "no such photo", "not yet" and "not yours", so a guest
  /// cannot even learn which shot ids exist before the reveal.
  static MehfilException _hidden() => MehfilException(
    code: 'hidden',
    message: 'This photo is not open yet.',
  );
}
