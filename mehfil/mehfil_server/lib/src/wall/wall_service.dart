import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Builds the live counts for an event. Counts only: this file never touches a
/// photo, a storage path or a guest's shot row content.
abstract final class WallService {
  static String channel(int eventId) => 'wall-$eventId';

  /// Tells every open wall of [eventId] to recount.
  static Future<void> tick(Session session, int eventId, String reason) {
    return session.messages.postMessage(
      channel(eventId),
      WallTick(eventId: eventId, reason: reason),
    );
  }

  static Future<WallSnapshot> snapshot(Session session, Event event) async {
    final eventId = event.id!;
    final rolls = await Roll.db.find(
      session,
      where: (t) => t.eventId.equals(eventId),
      orderBy: (t) => t.sortOrder,
    );

    final perRoll = await session.db.unsafeQuery(
      'SELECT "rollId", count(*) AS photos, count(DISTINCT "guestId") AS guests '
      'FROM shot_receipt WHERE "eventId" = @eventId AND "removedAt" IS NULL '
      'GROUP BY "rollId"',
      parameters: QueryParameters.named({'eventId': eventId}),
    );
    final counts = {
      for (final row in perRoll)
        row[0] as int: (photos: row[1] as int, guests: row[2] as int),
    };

    final photos = counts.values.fold<int>(0, (sum, c) => sum + c.photos);
    final guests = await Guest.db.count(
      session,
      where: (t) => t.eventId.equals(eventId),
    );

    // Shot rows reach the server through offline sync, usually before their
    // files do. Rows without a receipt are photos still waiting on phones.
    final waiting = await session.db.unsafeQuery(
      'SELECT count(*) FROM shot s WHERE s."eventId" = @eventId '
      'AND NOT EXISTS (SELECT 1 FROM shot_receipt r WHERE r."shotId" = s.id)',
      parameters: QueryParameters.named({'eventId': eventId}),
    );

    final activity = await _activity(session, eventId);

    return WallSnapshot(
      eventId: eventId,
      eventName: event.name,
      isDemo: event.isDemo,
      photos: photos,
      guests: guests,
      onPhones: waiting.first[0] as int,
      rolls: [
        for (final roll in rolls)
          RollCount(
            rollId: roll.id!,
            name: roll.name,
            revealAt: roll.revealAt,
            revealedAt: roll.revealedAt,
            photos: counts[roll.id]?.photos ?? 0,
            guests: counts[roll.id]?.guests ?? 0,
          ),
      ],
      activity: activity,
      serverNow: DateTime.now().toUtc(),
    );
  }

  /// The wall's "Just now" list: photo arrivals grouped per guest (a burst of
  /// uploads within two minutes is one line) and joins, newest first.
  static Future<List<WallActivity>> _activity(
    Session session,
    int eventId,
  ) async {
    final arrivals = await session.db.unsafeQuery(
      'SELECT g.name, r."receivedAt" FROM shot_receipt r '
      'JOIN guest g ON g.id = r."guestId" '
      'WHERE r."eventId" = @eventId AND r."removedAt" IS NULL '
      'ORDER BY r."receivedAt" DESC LIMIT 80',
      parameters: QueryParameters.named({'eventId': eventId}),
    );
    final items = <WallActivity>[];
    for (final row in arrivals) {
      final name = row[0] as String;
      final at = (row[1] as DateTime).toUtc();
      final last = items.isEmpty ? null : items.last;
      if (last != null &&
          last.name == name &&
          last.at.difference(at).inSeconds.abs() <= 120) {
        last.count += 1;
      } else {
        items.add(WallActivity(name: name, kind: 'photos', count: 1, at: at));
      }
    }
    final joins = await Guest.db.find(
      session,
      where: (t) => t.eventId.equals(eventId),
      orderBy: (t) => t.joinedAt.desc(),
      limit: 8,
    );
    items.addAll([
      for (final g in joins)
        WallActivity(
          name: g.name,
          kind: 'joined',
          count: 1,
          at: g.joinedAt.toUtc(),
        ),
    ]);
    items.sort((a, b) => b.at.compareTo(a.at));
    return items.take(6).toList();
  }
}
