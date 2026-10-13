import 'package:serverpod/serverpod.dart';

import 'reveal_service.dart';

/// The morning reveal. Scheduled with `callAtTime` and the roll's identifier,
/// stored in the database, so it fires even if the server restarts before it.
class RevealFutureCall extends FutureCall {
  Future<void> openRoll(Session session, int rollId) async {
    await RevealService.reveal(session, rollId, trigger: 'schedule');
  }
}
