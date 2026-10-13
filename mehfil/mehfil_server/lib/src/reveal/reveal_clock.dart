import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'reveal_service.dart';

/// A safety net under the future call. Every [interval] the server looks for
/// rolls whose reveal time passed more than [grace] ago and are still hidden,
/// and opens them with the same exactly-once reveal.
///
/// Where future calls run (any Serverpod server, Serverpod Cloud Growth) the
/// future call fires first, on the second, and this finds nothing to do. On
/// Serverpod Cloud's free Starter plan future calls are disabled, so this is
/// what opens the album there. Restart-safe: the reveal time lives in the
/// database, not in memory.
class RevealClock {
  RevealClock(
    this.pod, {
    this.interval = const Duration(seconds: 5),
    this.grace = const Duration(seconds: 45),
  });

  final Serverpod pod;
  final Duration interval;
  final Duration grace;
  Timer? _timer;
  bool _busy = false;

  void start() {
    _timer ??= Timer.periodic(interval, (_) => tick());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  /// One pass. Returns how many rolls this pass revealed.
  Future<int> tick() async {
    if (_busy) return 0;
    _busy = true;
    final session = await pod.createSession(enableLogging: false);
    try {
      return await revealOverdue(session, grace: grace);
    } catch (e, st) {
      session.log(
        'Reveal clock failed: $e',
        level: LogLevel.error,
        stackTrace: st,
      );
      return 0;
    } finally {
      await session.close();
      _busy = false;
    }
  }

  /// Opens every roll whose reveal time passed more than [grace] ago.
  static Future<int> revealOverdue(
    Session session, {
    required Duration grace,
  }) async {
    final due = DateTime.now().toUtc().subtract(grace);
    final rolls = await Roll.db.find(
      session,
      where: (t) => t.revealedAt.equals(null) & (t.revealAt < due),
    );
    var opened = 0;
    for (final roll in rolls) {
      if (await RevealService.reveal(session, roll.id!, trigger: 'clock')) {
        opened++;
      }
    }
    return opened;
  }
}
