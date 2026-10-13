import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// Access rules shared by every endpoint. The server is the only judge of who
/// may see what; the app only shows what these rules allow.
abstract final class Access {
  /// The signed-in user, or a [MehfilException] when there is none.
  static UuidValue userId(Session session) {
    final id = session.authenticated?.authUserId;
    if (id == null) {
      throw MehfilException(code: 'signed_out', message: 'Please sign in.');
    }
    return id;
  }

  /// The signed-in host. Hosts sign in with email; a guest's anonymous
  /// session from a QR code can shoot and view, but never create an event.
  static Future<UuidValue> hostId(Session session) async {
    final id = userId(session);
    final account = await EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(id),
    );
    if (account == null) {
      throw MehfilException(
        code: 'not_host',
        message: 'Sign in as a host to create an event.',
      );
    }
    return id;
  }

  static Future<Event> eventByCode(Session session, String joinCode) async {
    final event = await Event.db.findFirstRow(
      session,
      where: (t) => t.joinCode.equals(normalizeCode(joinCode)),
    );
    if (event == null) {
      throw MehfilException(
        code: 'no_event',
        message: 'This QR code does not belong to any event.',
      );
    }
    return event;
  }

  static Future<Event> eventById(Session session, int eventId) async {
    final event = await Event.db.findById(session, eventId);
    if (event == null) {
      throw MehfilException(code: 'no_event', message: 'Event not found.');
    }
    return event;
  }

  /// The event, if the signed-in user is its host.
  static Future<Event> hostedEvent(Session session, int eventId) async {
    final event = await eventById(session, eventId);
    if (event.hostUserId != userId(session)) {
      throw MehfilException(
        code: 'not_host',
        message: 'Only the host can do this.',
      );
    }
    return event;
  }

  /// The signed-in user's guest row in [eventId], or null.
  static Future<Guest?> guestOf(Session session, int eventId) {
    final user = userId(session);
    return Guest.db.findFirstRow(
      session,
      where: (t) => t.eventId.equals(eventId) & t.authUserId.equals(user),
    );
  }

  static Future<Roll> roll(Session session, int rollId) async {
    final roll = await Roll.db.findById(session, rollId);
    if (roll == null) {
      throw MehfilException(code: 'no_roll', message: 'Roll not found.');
    }
    return roll;
  }

  /// Join codes are typed by people: ignore case and stray spaces.
  static String normalizeCode(String code) =>
      code.trim().toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
}
