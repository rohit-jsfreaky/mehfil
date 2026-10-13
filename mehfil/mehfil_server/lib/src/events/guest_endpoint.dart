import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../generated/protocol.dart';
import '../reveal/reveal_service.dart';
import '../wall/wall_service.dart';

/// The guest side of an event: open the QR link, give a name, see the rolls.
/// Nothing here returns a photo.
class GuestEndpoint extends Endpoint {
  /// The server's clock. Phones use it for countdowns; their own clock is
  /// never trusted for the reveal.
  Future<DateTime> now(Session session) async => DateTime.now().toUtc();

  /// Public: what the QR link shows before sign-in. Names and times only.
  Future<EventPublic> event(Session session, String joinCode) async {
    final event = await Access.eventByCode(session, joinCode);
    return _public(session, event);
  }

  /// Joins (or re-joins) the event under [name]. Needs the anonymous sign-in
  /// that the QR page did first.
  Future<JoinResult> join(Session session, String joinCode, String name) async {
    final user = Access.userId(session);
    final event = await Access.eventByCode(session, joinCode);
    final cleanName = name.trim();
    if (cleanName.isEmpty || cleanName.length > 40) {
      throw MehfilException(
        code: 'invalid_name',
        message: 'Please enter a name (up to 40 letters).',
      );
    }

    var guest = await Access.guestOf(session, event.id!);
    if (guest == null) {
      guest = await Guest.db.insertRow(
        session,
        Guest(eventId: event.id!, authUserId: user, name: cleanName),
      );
      await WallService.tick(session, event.id!, 'join');
    } else if (guest.name != cleanName) {
      guest = await Guest.db.updateRow(
        session,
        guest.copyWith(name: cleanName),
      );
    }
    await RevealService.grantIfRevealed(session, event, guest);

    return JoinResult(
      event: await _public(session, event),
      guest: guest,
      albumSpaceId: event.albumSpaceId,
    );
  }

  /// The shot ids the server already has from this guest. The phone uses it
  /// to clear its queue after a reinstall or a lost reply.
  Future<List<UuidValue>> delivered(Session session, int eventId) async {
    final guest = await Access.guestOf(session, eventId);
    if (guest == null) return const [];
    final receipts = await ShotReceipt.db.find(
      session,
      where: (t) => t.guestId.equals(guest.id!),
    );
    return [for (final r in receipts) r.shotId];
  }

  Future<EventPublic> _public(Session session, Event event) async {
    final rolls = await Roll.db.find(
      session,
      where: (t) => t.eventId.equals(event.id!),
      orderBy: (t) => t.sortOrder,
    );
    final guests = await Guest.db.find(
      session,
      where: (t) => t.eventId.equals(event.id!),
      orderBy: (t) => t.joinedAt,
    );
    return EventPublic(
      eventId: event.id!,
      name: event.name,
      hostedBy: event.hostedBy,
      guests: guests.length,
      guestNames: [for (final g in guests.take(5)) g.name.split(' ').first],
      joinCode: event.joinCode,
      isDemo: event.isDemo,
      rolls: rolls,
      serverNow: DateTime.now().toUtc(),
    );
  }
}
