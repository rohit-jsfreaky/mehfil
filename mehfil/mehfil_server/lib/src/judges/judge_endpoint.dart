import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../generated/protocol.dart';

/// Powers the "Try to break it" page. Only demo events answer, and the answer
/// is an id, never a photo: the point is to show the server refusing.
class JudgeEndpoint extends Endpoint {
  Future<JudgeSample?> hiddenSample(Session session, String joinCode) async {
    final event = await Access.eventByCode(session, joinCode);
    if (!event.isDemo) {
      throw MehfilException(
        code: 'not_demo',
        message: 'The attack page only runs on demo events.',
      );
    }
    final hidden = await Roll.db.find(
      session,
      where: (t) => t.eventId.equals(event.id!) & t.revealedAt.equals(null),
    );
    if (hidden.isEmpty) return null;
    final receipt = await ShotReceipt.db.findFirstRow(
      session,
      where: (t) =>
          t.rollId.inSet({for (final r in hidden) r.id!}) &
          t.removedAt.equals(null),
      orderBy: (t) => t.receivedAt,
    );
    if (receipt == null) return null;
    return JudgeSample(
      shotId: receipt.shotId,
      eventId: receipt.eventId,
      rollId: receipt.rollId,
      guessedPath: receipt.storagePath,
    );
  }
}
