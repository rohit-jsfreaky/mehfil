import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

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
    String? recoveryKey;
    if (guest == null) {
      recoveryKey = _newRecoveryKey();
      guest = await Guest.db.insertRow(
        session,
        Guest(
          eventId: event.id!,
          authUserId: user,
          name: cleanName,
          recoveryHash: _hash(recoveryKey),
        ),
      );
      await WallService.tick(session, event.id!, 'join');
    } else {
      final changed = guest.name != cleanName || guest.recoveryHash == null;
      if (guest.recoveryHash == null) {
        // Joined before recovery keys existed.
        recoveryKey = _newRecoveryKey();
        guest = guest.copyWith(recoveryHash: _hash(recoveryKey));
      }
      if (changed) {
        guest = await Guest.db.updateRow(
          session,
          guest.copyWith(name: cleanName),
        );
      }
    }
    await RevealService.grantIfRevealed(session, event, guest);

    return JoinResult(
      event: await _public(session, event),
      guest: guest,
      albumSpaceId: event.albumSpaceId,
      recoveryKey: recoveryKey,
    );
  }

  /// Gets a guest whose session was lost back in, as the same person: same
  /// account, same queued photos, same name on the album. The phone proves it
  /// is that guest with the recovery key it got when it first joined.
  Future<AuthSuccess> recover(
    Session session,
    String joinCode,
    int guestId,
    String recoveryKey,
  ) async {
    final event = await Access.eventByCode(session, joinCode);
    final guest = await Guest.db.findById(session, guestId);
    final stored = guest?.recoveryHash;
    if (guest == null ||
        guest.eventId != event.id ||
        stored == null ||
        !_sameHash(stored, _hash(recoveryKey))) {
      throw MehfilException(
        code: 'recovery_failed',
        message: 'Please scan the QR code again to rejoin.',
      );
    }
    return AuthServices.instance.tokenManager.issueToken(
      session,
      authUserId: guest.authUserId,
      method: 'anonymous',
    );
  }

  static String _newRecoveryKey() {
    final random = Random.secure();
    return base64Url.encode([for (var i = 0; i < 32; i++) random.nextInt(256)]);
  }

  static String _hash(String key) =>
      sha256.convert(utf8.encode(key)).toString();

  /// Compares in constant time, so timing reveals nothing about the hash.
  static bool _sameHash(String a, String b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return diff == 0;
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
