import 'package:serverpod/serverpod.dart';
import 'package:serverpod_offline_sync_server/serverpod_offline_sync_server.dart';

import '../generated/future_calls.dart';
import '../generated/protocol.dart';
import '../wall/wall_service.dart';

/// Opens a roll for everyone. Safe to call any number of times, from the
/// future call, from "Reveal now", or after a restart: the unique `reveal_log`
/// row makes the reveal itself happen exactly once.
abstract final class RevealService {
  static String identifier(int rollId) => 'reveal-roll-$rollId';

  /// Schedules (or moves) the reveal of [roll] to its `revealAt`.
  static Future<void> schedule(Session session, Roll roll) async {
    try {
      final futureCalls = session.serverpod.futureCalls;
      await futureCalls.cancel(identifier(roll.id!));
      await futureCalls
          .callAtTime(roll.revealAt.toUtc(), identifier: identifier(roll.id!))
          .reveal
          .openRoll(roll.id!);
    } catch (e) {
      // Where future calls are switched off (Serverpod Cloud Starter), the
      // reveal clock opens the roll instead. Creating the event must not fail.
      session.log(
        'Future call not scheduled for roll ${roll.id}: $e',
        level: LogLevel.warning,
      );
    }
  }

  /// False where future calls are switched off (Serverpod Cloud Starter):
  /// there the reveal clock is what opens rolls, so it runs with no grace.
  static Future<bool> futureCallsAvailable(Session session) async {
    try {
      await session.serverpod.futureCalls.cancel('mehfil-availability-probe');
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Cancels the scheduled reveal of [rollId], if there is one.
  static Future<void> unschedule(Session session, int rollId) async {
    try {
      await session.serverpod.futureCalls.cancel(identifier(rollId));
    } catch (e) {
      // Nothing was scheduled where future calls are switched off.
      session.log(
        'Future call not cancelled for roll $rollId: $e',
        level: LogLevel.warning,
      );
    }
  }

  /// Returns true when this call is the one that revealed the roll.
  static Future<bool> reveal(
    Session session,
    int rollId, {
    required String trigger,
  }) async {
    final roll = await Roll.db.findById(session, rollId);
    if (roll == null) return false;
    final event = await Event.db.findById(session, roll.eventId);
    if (event == null) return false;

    final now = DateTime.now().toUtc();
    final claimed = await session.db.unsafeExecute(
      'INSERT INTO reveal_log ("rollId", "trigger", "photos", "revealedAt") '
      'VALUES (@rollId, @trigger, 0, @now) ON CONFLICT ("rollId") DO NOTHING',
      parameters: QueryParameters.named({
        'rollId': rollId,
        'trigger': trigger,
        'now': now,
      }),
    );
    final firstReveal = claimed == 1;
    if (firstReveal) {
      await Roll.db.updateRow(session, roll.copyWith(revealedAt: now));
    }

    // Publishing is idempotent, so a reveal cut short by a crash is finished
    // by the next call (a late upload, or the startup sweep).
    final published = await publish(session, event, roll);
    await _grantGuests(session, event);
    if (firstReveal) {
      await session.db.unsafeExecute(
        'UPDATE reveal_log SET photos = @photos WHERE "rollId" = @rollId',
        parameters: QueryParameters.named({
          'photos': published,
          'rollId': rollId,
        }),
      );
      session.log('Revealed roll $rollId ($trigger): $published photos.');
    }
    await WallService.tick(session, event.id!, 'reveal');
    return firstReveal;
  }

  /// Copies every received photo of [roll] into the event's album space,
  /// skipping the ones already there. Returns how many photos the album holds
  /// for the roll.
  static Future<int> publish(Session session, Event event, Roll roll) async {
    final receipts = await ShotReceipt.db.find(
      session,
      where: (t) => t.rollId.equals(roll.id!) & t.removedAt.equals(null),
      orderBy: (t) => t.receivedAt,
    );
    if (receipts.isEmpty) return 0;

    final guests = {
      for (final g in await Guest.db.find(
        session,
        where: (t) => t.eventId.equals(event.id!),
      ))
        g.id!: g.name,
    };

    return _syncDb(session).transactionForUser(
      event.hostUserId,
      spaceId: event.albumSpaceId,
      (tx) async {
        final existing = await AlbumPhoto.db.find(
          session,
          where: (t) => t.rollId.equals(roll.id!),
          transaction: tx,
        );
        final have = {for (final p in existing) p.shotId};
        final missing = [
          for (final r in receipts)
            if (!have.contains(r.shotId))
              AlbumPhoto(
                shotId: r.shotId,
                eventId: event.id!,
                rollId: roll.id!,
                rollName: roll.name,
                guestName: guests[r.guestId] ?? 'Guest',
                takenAt: r.takenAt,
                receivedAt: r.receivedAt,
                width: r.width,
                height: r.height,
              ),
        ];
        if (missing.isNotEmpty) {
          await AlbumPhoto.db.insert(session, missing, transaction: tx);
        }
        return existing.length + missing.length;
      },
    );
  }

  /// Takes a removed photo out of the album space. Offline sync then removes
  /// it from every phone that has the album.
  static Future<void> unpublish(
    Session session,
    Event event,
    UuidValue shotId,
  ) async {
    await _syncDb(session).transactionForUser(
      event.hostUserId,
      spaceId: event.albumSpaceId,
      (tx) async {
        await AlbumPhoto.db.deleteWhere(
          session,
          where: (t) => t.shotId.equals(shotId),
          transaction: tx,
        );
      },
    );
  }

  /// The session's CRDT-aware database. Sessions on the running server already
  /// carry it; the test harness wraps its own proxy, so wrap on demand.
  static OfflineSyncDatabase _syncDb(Session session) {
    final db = session.db;
    if (db is OfflineSyncDatabase) return db;
    return offlineSyncDatabaseInterceptor(session, db) as OfflineSyncDatabase;
  }

  /// Every guest of the event becomes a read-only member of the album space.
  /// Phones that are syncing pick it up on their next sync cycle.
  static Future<void> _grantGuests(Session session, Event event) async {
    final guests = await Guest.db.find(
      session,
      where: (t) => t.eventId.equals(event.id!),
    );
    final grants = {
      for (final g in guests)
        if (g.authUserId != event.hostUserId)
          g.authUserId: OfflineSyncSpaceRole.readOnly,
    };
    if (grants.isEmpty) return;
    await session.offlineSync.spaces.grantAll(event.albumSpaceId, grants);
  }

  /// Grants one late guest access when the event already has a revealed roll.
  static Future<void> grantIfRevealed(
    Session session,
    Event event,
    Guest guest,
  ) async {
    final revealed = await Roll.db.count(
      session,
      where: (t) => t.eventId.equals(event.id!) & t.revealedAt.notEquals(null),
    );
    if (revealed == 0 || guest.authUserId == event.hostUserId) return;
    await session.offlineSync.spaces.grant(
      space: event.albumSpaceId,
      user: guest.authUserId,
      role: OfflineSyncSpaceRole.readOnly,
    );
  }

  /// After a restart: finish any reveal that is due but not published, and
  /// re-arm reveals that are still in the future. Future calls survive
  /// restarts on their own; this sweep only repairs a reveal cut short midway.
  static Future<void> sweep(Session session) async {
    final now = DateTime.now().toUtc();
    final due = await Roll.db.find(
      session,
      where: (t) => t.revealedAt.notEquals(null),
    );
    for (final roll in due) {
      final event = await Event.db.findById(session, roll.eventId);
      if (event == null) continue;
      await publish(session, event, roll);
      await _grantGuests(session, event);
    }
    session.log('Reveal sweep done at $now: ${due.length} revealed rolls.');
  }
}
