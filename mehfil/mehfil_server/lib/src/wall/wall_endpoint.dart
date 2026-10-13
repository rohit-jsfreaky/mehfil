import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../generated/protocol.dart';
import 'wall_service.dart';

/// The live wall: counts that climb as photos land, over a WebSocket stream.
/// Anyone with the join code may watch it, because it carries no photos.
class WallEndpoint extends Endpoint {
  /// Sends a fresh snapshot now, on every event tick, and every few seconds
  /// (shot rows arriving through offline sync change the "on phones" count).
  Stream<WallSnapshot> watch(Session session, String joinCode) async* {
    final event = await Access.eventByCode(session, joinCode);
    final updates = StreamController<void>();
    final ticks = session.messages
        .createStream<WallTick>(WallService.channel(event.id!))
        .listen((_) => updates.add(null));
    final timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) => updates.add(null),
    );
    try {
      WallSnapshot? last;
      yield last = await WallService.snapshot(session, event);
      await for (final _ in updates.stream) {
        final next = await WallService.snapshot(session, event);
        if (_sameCounts(last!, next)) continue;
        yield last = next;
      }
    } finally {
      timer.cancel();
      await ticks.cancel();
      await updates.close();
    }
  }

  Future<WallSnapshot> snapshot(Session session, String joinCode) async {
    final event = await Access.eventByCode(session, joinCode);
    return WallService.snapshot(session, event);
  }

  static bool _sameCounts(WallSnapshot a, WallSnapshot b) {
    if (a.photos != b.photos ||
        a.guests != b.guests ||
        a.onPhones != b.onPhones ||
        a.rolls.length != b.rolls.length) {
      return false;
    }
    for (var i = 0; i < a.rolls.length; i++) {
      final x = a.rolls[i], y = b.rolls[i];
      if (x.photos != y.photos ||
          x.guests != y.guests ||
          x.revealAt != y.revealAt ||
          x.revealedAt != y.revealedAt) {
        return false;
      }
    }
    return true;
  }
}
