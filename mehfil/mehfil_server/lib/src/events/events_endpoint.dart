import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_offline_sync_server/serverpod_offline_sync_server.dart';

import '../core/access.dart';
import '../generated/protocol.dart';
import '../reveal/reveal_service.dart';
import '../shots/shot_endpoint.dart';
import '../wall/wall_service.dart';

/// What the host (the couple, the family) can do: create the event, set the
/// rolls and reveal times, and open a roll early.
class EventsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const _codeAlphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';

  Future<HostEvent> createEvent(
    Session session,
    String name,
    List<RollDraft> rolls, {
    bool isDemo = false,
    String? hostedBy,
  }) async {
    final host = await Access.hostId(session);
    final cleanName = name.trim();
    if (cleanName.isEmpty || rolls.isEmpty) {
      throw MehfilException(
        code: 'invalid',
        message: 'An event needs a name and at least one roll.',
      );
    }

    final event = await session.db.transaction((tx) async {
      final albumSpace = await session.offlineSync.spaces.createFor(
        host,
        role: OfflineSyncSpaceRole.readWrite,
        transaction: tx,
      );
      final event = await Event.db.insertRow(
        session,
        Event(
          name: cleanName,
          hostedBy: (hostedBy?.trim().isEmpty ?? true)
              ? null
              : hostedBy!.trim(),
          joinCode: await _freshCode(session, tx),
          hostUserId: host,
          albumSpaceId: albumSpace,
          isDemo: isDemo,
        ),
        transaction: tx,
      );
      await Roll.db.insert(
        session,
        [
          for (final (i, draft) in rolls.indexed)
            Roll(
              eventId: event.id!,
              name: draft.name.trim(),
              sortOrder: i,
              revealAt: draft.revealAt.toUtc(),
              shotsPerGuest: draft.shotsPerGuest,
            ),
        ],
        transaction: tx,
      );
      return event;
    });

    final saved = await _rolls(session, event.id!);
    for (final roll in saved) {
      await RevealService.schedule(session, roll);
    }
    return _view(session, event);
  }

  Future<List<HostEvent>> myEvents(Session session) async {
    final host = Access.userId(session);
    final events = await Event.db.find(
      session,
      where: (t) => t.hostUserId.equals(host),
      orderBy: (t) => t.createdAt.desc(),
    );
    return [for (final e in events) await _view(session, e)];
  }

  Future<HostEvent> addRoll(
    Session session,
    int eventId,
    RollDraft draft,
  ) async {
    final event = await Access.hostedEvent(session, eventId);
    final count = await Roll.db.count(
      session,
      where: (t) => t.eventId.equals(eventId),
    );
    final roll = await Roll.db.insertRow(
      session,
      Roll(
        eventId: eventId,
        name: draft.name.trim(),
        sortOrder: count,
        revealAt: draft.revealAt.toUtc(),
        shotsPerGuest: draft.shotsPerGuest,
      ),
    );
    await RevealService.schedule(session, roll);
    await WallService.tick(session, eventId, 'roll');
    return _view(session, event);
  }

  /// Moves a reveal: cancels the scheduled call by its identifier and books a
  /// new one. A roll that is already open stays open.
  Future<Roll> setRevealTime(
    Session session,
    int rollId,
    DateTime revealAt,
  ) async {
    final roll = await Access.roll(session, rollId);
    await Access.hostedEvent(session, roll.eventId);
    if (roll.revealedAt != null) {
      throw MehfilException(
        code: 'already_revealed',
        message: 'This roll is already open.',
      );
    }
    final updated = await Roll.db.updateRow(
      session,
      roll.copyWith(revealAt: revealAt.toUtc()),
    );
    await RevealService.schedule(session, updated);
    await WallService.tick(session, roll.eventId, 'reveal-time');
    return updated;
  }

  /// Opens a roll now (for a host in a hurry, and for judges).
  Future<Roll> revealNow(Session session, int rollId) async {
    final roll = await Access.roll(session, rollId);
    await Access.hostedEvent(session, roll.eventId);
    await RevealService.unschedule(session, rollId);
    await RevealService.reveal(session, rollId, trigger: 'host');
    return Access.roll(session, rollId);
  }

  /// The revealed album, for the host's screen (to look through and to remove
  /// a photo). Hidden rolls return nothing, the same rule guests get.
  Future<List<AlbumPhoto>> album(Session session, int eventId) async {
    await Access.hostedEvent(session, eventId);
    final open = await Roll.db.find(
      session,
      where: (t) => t.eventId.equals(eventId) & t.revealedAt.notEquals(null),
    );
    if (open.isEmpty) return const [];
    final removed = await ShotReceipt.db.find(
      session,
      where: (t) => t.eventId.equals(eventId) & t.removedAt.notEquals(null),
    );
    final gone = {for (final r in removed) r.shotId};
    final photos = await AlbumPhoto.db.find(
      session,
      where: (t) => t.rollId.inSet({for (final r in open) r.id!}),
      orderBy: (t) => t.receivedAt,
    );
    return [
      for (final p in photos)
        if (!gone.contains(p.shotId)) p,
    ];
  }

  /// Removes a photo for everyone (the host's privacy control). The receipt
  /// stays, marked removed, so the delivery evidence still shows it arrived;
  /// the files are deleted and the album copy leaves every phone on next sync.
  Future<void> removePhoto(Session session, UuidValue shotId) async {
    final receipt = await ShotReceipt.db.findFirstRow(
      session,
      where: (t) => t.shotId.equals(shotId),
    );
    if (receipt == null) {
      throw MehfilException(code: 'no_photo', message: 'Photo not found.');
    }
    final event = await Access.hostedEvent(session, receipt.eventId);
    if (receipt.removedAt != null) return;
    await ShotReceipt.db.updateRow(
      session,
      receipt.copyWith(removedAt: DateTime.now().toUtc()),
    );
    await RevealService.unpublish(session, event, shotId);
    for (final path in [receipt.storagePath, receipt.thumbPath]) {
      await session.storage.deleteFile(
        storageId: ShotEndpoint.storageId,
        path: path,
      );
    }
    await WallService.tick(session, event.id!, 'removed');
  }

  /// Rows (offline sync) and files (uploads) the server holds, per guest.
  Future<DeliveryReport> delivery(Session session, int eventId) async {
    await Access.hostedEvent(session, eventId);
    final rows = await session.db.unsafeQuery(
      'SELECT g.name, '
      // A guest's rows live in their personal sync space (uuid = user id).
      '  (SELECT count(*) FROM shot s JOIN offline_sync_spaces sp ON sp.id = s."spaceId" '
      '     WHERE s."eventId" = @e AND sp."uuidSpaceId" = g."authUserId"), '
      '  (SELECT count(*) FROM shot_receipt r WHERE r."guestId" = g.id), '
      '  (SELECT count(*) FROM shot_receipt r JOIN shot s ON s.id = r."shotId" '
      '     WHERE r."guestId" = g.id) '
      'FROM guest g WHERE g."eventId" = @e ORDER BY g.name',
      parameters: QueryParameters.named({'e': eventId}),
    );
    final totals = await session.db.unsafeQuery(
      'SELECT '
      '  (SELECT count(*) FROM shot WHERE "eventId" = @e), '
      '  (SELECT count(*) FROM shot_receipt WHERE "eventId" = @e), '
      '  (SELECT count(*) FROM shot_receipt r JOIN shot s ON s.id = r."shotId" '
      '     WHERE r."eventId" = @e)',
      parameters: QueryParameters.named({'e': eventId}),
    );
    final waits = await session.db.unsafeQuery(
      "SELECT count(*) FILTER (WHERE \"receivedAt\" - \"takenAt\" > interval '60 seconds'), "
      '  coalesce(max(extract(epoch FROM ("receivedAt" - "takenAt")))::bigint, 0) '
      'FROM shot_receipt WHERE "eventId" = @e',
      parameters: QueryParameters.named({'e': eventId}),
    );
    final t = totals.first;
    final synced = t[0] as int, files = t[1] as int, both = t[2] as int;
    return DeliveryReport(
      eventId: eventId,
      rowsSynced: synced,
      filesReceived: files,
      delivered: both,
      rowsWithoutFile: synced - both,
      filesWithoutRow: files - both,
      waitedOverMinute: waits.first[0] as int,
      longestWaitSeconds: waits.first[1] as int,
      guests: [
        for (final r in rows)
          GuestDelivery(
            name: r[0] as String,
            rowsSynced: r[1] as int,
            filesReceived: r[2] as int,
            delivered: r[3] as int,
          ),
      ],
      serverNow: DateTime.now().toUtc(),
    );
  }

  /// Every reveal of the event, with what triggered it and the server time.
  Future<List<RevealLog>> reveals(Session session, int eventId) async {
    await Access.hostedEvent(session, eventId);
    final rolls = await _rolls(session, eventId);
    return RevealLog.db.find(
      session,
      where: (t) => t.rollId.inSet({for (final r in rolls) r.id!}),
      orderBy: (t) => t.revealedAt,
    );
  }

  Future<String> _freshCode(Session session, Transaction tx) async {
    final random = Random.secure();
    while (true) {
      final code = List.generate(
        6,
        (_) => _codeAlphabet[random.nextInt(_codeAlphabet.length)],
      ).join();
      final taken = await Event.db.count(
        session,
        where: (t) => t.joinCode.equals(code),
        transaction: tx,
      );
      if (taken == 0) return code;
    }
  }

  Future<List<Roll>> _rolls(Session session, int eventId) => Roll.db.find(
    session,
    where: (t) => t.eventId.equals(eventId),
    orderBy: (t) => t.sortOrder,
  );

  Future<HostEvent> _view(Session session, Event event) async {
    return HostEvent(
      event: event,
      rolls: await _rolls(session, event.id!),
      photos: await ShotReceipt.db.count(
        session,
        where: (t) => t.eventId.equals(event.id!),
      ),
      guests: await Guest.db.count(
        session,
        where: (t) => t.eventId.equals(event.id!),
      ),
    );
  }
}
