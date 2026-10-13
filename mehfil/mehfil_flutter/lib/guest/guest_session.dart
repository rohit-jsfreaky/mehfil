import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:mehfil_client/mehfil_client.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../client.dart';

/// Everything a guest's phone does for one event.
///
/// A photo is first written to the phone: a `Shot` row in the guest's
/// personal sync space and its bytes in the `PendingUpload` table, in one
/// local transaction. Nothing needs the network for that. Then two loops run
/// whenever there is signal: offline sync carries the rows, and the uploader
/// sends the files. A queued photo is removed only after the server answers
/// that it stored it.
class GuestSession extends ChangeNotifier {
  GuestSession._(this.joinCode, this._prefs);

  final String joinCode;
  final SharedPreferences _prefs;

  late JoinResult _join;
  late OfflineSyncDatabaseSession _local;

  OfflineSyncSubscription? _sync;
  StreamSubscription<WallSnapshot>? _wall;
  Timer? _ticker;
  bool _pumping = false;
  bool _closed = false;
  Duration _backoff = const Duration(seconds: 2);
  DateTime _nextAttempt = DateTime.fromMillisecondsSinceEpoch(0);

  /// Last thing we know about the network: false only after a request
  /// failed, true again after any server reply. "No signal" is shown only
  /// when there is evidence for it, not while the first reply is on its way.
  bool online = true;

  /// Photos saved on this phone and not yet confirmed by the server.
  int waiting = 0;

  /// Photos the server confirmed.
  int delivered = 0;

  /// This guest's shots per roll (from the phone's own database).
  Map<int, int> shotsByRoll = {};

  /// Revealed photos that reached this phone through offline sync.
  List<AlbumPhoto> album = const [];

  /// Server clock minus phone clock, so countdowns use server time.
  Duration serverOffset = Duration.zero;

  /// The latest live counts for the event (from the wall stream).
  WallSnapshot? wall;

  /// Photos sent since the queue last emptied, for "Sending 2 of 3".
  int sentThisBatch = 0;

  String? lastError;

  JoinResult get join => _join;
  EventPublic get event => _join.event;
  Guest get guest => _join.guest;
  List<Roll> get rolls => _join.event.rolls;
  OfflineSyncDatabaseSession get local => _local;

  DateTime get serverNow => DateTime.now().toUtc().add(serverOffset);

  static String _key(String code) => 'mehfil.join.${code.toUpperCase()}';

  /// The saved join for [code] on this device, if the guest joined before.
  static Future<JoinResult?> saved(String code) async {
    final join = await _savedJoin(code);
    if (join == null) return null;
    final signedIn = client.auth.authInfo?.authUserId;
    if (signedIn == join.guest.authUserId) return join;
    // Someone else is signed in on this browser (a host, say).
    if (signedIn != null) return null;
    // This phone's session was lost (a token refresh cut short when the tab
    // went to the background). Get the same guest back with the recovery key,
    // so the photos waiting on the phone still go out under this name.
    if (join.recoveryKey == null) return null;
    try {
      await _recover(join);
    } on MehfilException {
      return null; // The server said no: join again from the QR.
    } catch (_) {
      // No signal. Open anyway; the session recovers once back online.
    }
    return join;
  }

  static Future<JoinResult?> _savedJoin(String code) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key(code));
    if (raw == null) return null;
    try {
      return JoinResult.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  /// Signs this phone back in as the guest in [join].
  static Future<void> _recover(JoinResult join) async {
    final ok = await client.guest.recover(
      join.event.joinCode,
      join.guest.id!,
      join.recoveryKey!,
    );
    await client.auth.updateSignedInUser(ok);
  }

  /// First visit: sign in with the QR's code, then join under [name].
  static Future<JoinResult> joinEvent(String code, String name) async {
    if (!client.auth.isAuthenticated) {
      final ok = await client.anonymousIdp.login(token: code);
      await client.auth.updateSignedInUser(ok);
    }
    var join = await client.guest.join(code, name);
    // The server sends the recovery key only once: keep the one we have.
    final before = await _savedJoin(code);
    if (join.recoveryKey == null && before?.guest.id == join.guest.id) {
      join = join.copyWith(recoveryKey: before?.recoveryKey);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key(code), jsonEncode(join.toJson()));
    return join;
  }

  /// Opens the phone's database and starts the loops. Works with no signal
  /// once the guest has joined on this device.
  static Future<GuestSession> open(JoinResult join) async {
    final prefs = await SharedPreferences.getInstance();
    final session = GuestSession._(join.event.joinCode, prefs).._join = join;
    final userId = join.guest.authUserId;
    session._local = await client.createSyncSession(
      await _databasePath('mehfil-${userId.uuid}.db'),
      isDebugMode: kDebugMode,
      persistentUserId: userId,
    );
    await session._refreshCounts();
    session._start();
    return session;
  }

  static Future<String> _databasePath(String name) async {
    if (kIsWeb) return name;
    final dir = await getApplicationSupportDirectory();
    return p.join(dir.path, name);
  }

  void _start() {
    client.auth.authInfoListenable.addListener(_onAuthChanged);
    _startSync();
    _watchWall();
    unawaited(_reconcile());
    _ticker = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!client.auth.isAuthenticated) unawaited(_recoverSession());
      if (waiting > 0) unawaited(pump());
      if (_wall == null) _watchWall();
    });
    unawaited(pump());
  }

  // ---------------------------------------------------------------- session

  bool _recovering = false;

  void _onAuthChanged() {
    if (!client.auth.isAuthenticated) unawaited(_recoverSession());
  }

  /// Gets this guest signed back in after the session was lost, without a
  /// new name or a new account. Photos keep waiting safely meanwhile.
  Future<void> _recoverSession() async {
    if (_recovering || _closed || client.auth.isAuthenticated) return;
    if (_join.recoveryKey == null) return;
    _recovering = true;
    try {
      await _recover(_join);
      _markOnline();
      if (_wall == null) _watchWall();
      unawaited(_reconcile());
      unawaited(pump());
    } on MehfilException catch (e) {
      lastError = e.message;
      notifyListeners();
    } catch (_) {
      _markOffline();
    } finally {
      _recovering = false;
    }
  }

  /// The server answered "please sign in": the session on this phone is dead
  /// even if it still looks signed in. Drop it and recover.
  Future<void> _sessionLost() async {
    if (client.auth.isAuthenticated) await client.auth.updateSignedInUser(null);
    await _recoverSession();
  }

  // ---------------------------------------------------------------- capture

  /// The roll a new photo goes to: the first one that is not open yet.
  Roll? get currentRoll {
    for (final r in rolls) {
      if (r.revealedAt == null) return r;
    }
    return null;
  }

  int shotsLeft(Roll roll) =>
      (roll.shotsPerGuest - (shotsByRoll[roll.id] ?? 0)).clamp(0, 9999);

  /// Saves a photo on the phone. Returns as soon as it is safe locally.
  Future<void> capture(Uint8List jpeg, {required Roll roll}) async {
    final id = UuidValue.fromString(const Uuid().v7());
    final shot = Shot(
      id: id,
      eventId: event.eventId,
      rollId: roll.id!,
      guestName: guest.name,
      takenAt: DateTime.now().toUtc(),
      sha256: sha256.convert(jpeg).toString(),
      width: 0,
      height: 0,
      sizeBytes: jpeg.length,
    );
    await _local.db.transaction((tx) async {
      await Shot.db.insertRow(_local, shot, transaction: tx);
      await PendingUpload.db.insertRow(
        _local,
        PendingUpload(
          shotId: id,
          eventId: event.eventId,
          rollId: roll.id!,
          bytes: ByteData.sublistView(jpeg),
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: tx,
      );
    });
    await _refreshCounts();
    _nextAttempt = DateTime.fromMillisecondsSinceEpoch(0);
    unawaited(pump());
  }

  // ---------------------------------------------------------------- upload

  /// Sends queued photos, oldest first, until the queue is empty or the
  /// network fails. Safe to call any time; only one pump runs at once.
  Future<void> pump() async {
    if (_pumping || _closed || DateTime.now().isBefore(_nextAttempt)) return;
    _pumping = true;
    try {
      while (!_closed) {
        final next = await PendingUpload.db.findFirstRow(
          _local,
          orderBy: (t) => t.createdAt,
        );
        if (next == null) break;
        final shot = await Shot.db.findById(_local, next.shotId);
        try {
          await client.shot
              .upload(
                shotId: next.shotId,
                rollId: next.rollId,
                takenAt: shot?.takenAt ?? next.createdAt,
                sha256Hex:
                    shot?.sha256 ??
                    sha256.convert(_bytesOf(next.bytes)).toString(),
                bytes: next.bytes,
              )
              .timeout(const Duration(seconds: 90));
          await PendingUpload.db.deleteRow(_local, next);
          sentThisBatch++;
          _markOnline();
          await _refreshCounts();
        } on MehfilException catch (e) {
          _markOnline();
          if (e.code == 'signed_out') {
            await _sessionLost();
            if (!client.auth.isAuthenticated) break;
            continue;
          }
          if (e.code == 'not_joined') {
            await client.guest.join(joinCode, guest.name);
            continue;
          }
          // The server refused this one (damaged on the way, etc.). Keep it,
          // count the attempt, and move on to the next photo.
          await PendingUpload.db.updateRow(
            _local,
            next.copyWith(
              attempts: next.attempts + 1,
              lastError: e.message,
              createdAt: DateTime.now().toUtc(),
            ),
          );
          lastError = e.message;
          notifyListeners();
          if (next.attempts + 1 >= 3) break;
        } catch (e) {
          _markOffline();
          break;
        }
      }
    } finally {
      _pumping = false;
    }
  }

  static Uint8List _bytesOf(ByteData b) =>
      b.buffer.asUint8List(b.offsetInBytes, b.lengthInBytes);

  /// After a reinstall or a lost reply: drop queued photos the server
  /// already has.
  Future<void> _reconcile() async {
    try {
      final have = (await client.guest.delivered(event.eventId)).toSet();
      _markOnline();
      if (have.isEmpty) return;
      await PendingUpload.db.deleteWhere(
        _local,
        where: (t) => t.shotId.inSet(have),
      );
      await _refreshCounts();
    } on MehfilException catch (e) {
      _markOnline();
      if (e.code == 'signed_out') unawaited(_sessionLost());
    } catch (_) {
      _markOffline();
    }
  }

  void _markOnline() {
    _backoff = const Duration(seconds: 2);
    _nextAttempt = DateTime.fromMillisecondsSinceEpoch(0);
    if (!online) {
      online = true;
      notifyListeners();
    }
  }

  void _markOffline() {
    _nextAttempt = DateTime.now().add(_backoff);
    _backoff = Duration(
      milliseconds: (_backoff.inMilliseconds * 2).clamp(2000, 20000),
    );
    if (online) {
      online = false;
      notifyListeners();
    }
  }

  // ---------------------------------------------------------------- sync

  /// Keeps offline sync running; restarts it after it drops.
  void _startSync() {
    if (_closed) return;
    final sub = client.offlineSync.syncContinuously(
      _local,
      onMergeSuccess: (_, _) => _refreshCounts(),
    );
    _sync = sub;
    sub.done.then((_) {}, onError: (_) {}).whenComplete(() {
      if (_closed || !identical(_sync, sub)) return;
      Future<void>.delayed(const Duration(seconds: 4), _startSync);
    });
  }

  /// Follows the event's live counts; this is how the phone learns about the
  /// reveal the moment it happens.
  void _watchWall() {
    if (_closed) return;
    _wall = client.wall
        .watch(joinCode)
        .listen(
          (snap) {
            _markOnline();
            wall = snap;
            serverOffset = snap.serverNow.difference(DateTime.now().toUtc());
            var changed = false;
            final rolls = [
              for (final r in _join.event.rolls)
                () {
                  final live = snap.rolls
                      .where((c) => c.rollId == r.id)
                      .firstOrNull;
                  if (live == null) return r;
                  if (live.revealedAt != r.revealedAt ||
                      live.revealAt != r.revealAt) {
                    changed = true;
                    return r.copyWith(
                      revealedAt: live.revealedAt,
                      revealAt: live.revealAt,
                    );
                  }
                  return r;
                }(),
            ];
            notifyListeners();
            if (changed) {
              _join = _join.copyWith(event: _join.event.copyWith(rolls: rolls));
              unawaited(
                _prefs.setString(_key(joinCode), jsonEncode(_join.toJson())),
              );
              // The album space was just granted: pull it now.
              unawaited(
                client.offlineSync
                    .syncOnce(_local)
                    .then((_) => _refreshCounts())
                    .catchError((_) {}),
              );
              notifyListeners();
            }
          },
          onError: (_) {
            _markOffline();
            _wall = null;
          },
          onDone: () => _wall = null,
          cancelOnError: true,
        );
  }

  Future<void> _refreshCounts() async {
    if (_closed) return;
    final shots = await Shot.db.find(_local);
    final byRoll = <int, int>{};
    for (final s in shots) {
      if (s.eventId != event.eventId) continue;
      byRoll[s.rollId] = (byRoll[s.rollId] ?? 0) + 1;
    }
    final pending = await PendingUpload.db.count(
      _local,
      where: (t) => t.eventId.equals(event.eventId),
    );
    final photos = await AlbumPhoto.db.find(
      _local,
      where: (t) => t.eventId.equals(event.eventId),
      orderBy: (t) => t.receivedAt,
    );
    shotsByRoll = byRoll;
    if (pending == 0) sentThisBatch = 0;
    waiting = pending;
    delivered = byRoll.values.fold(0, (a, b) => a + b) - pending;
    album = photos;
    notifyListeners();
  }

  @override
  void dispose() {
    _closed = true;
    client.auth.authInfoListenable.removeListener(_onAuthChanged);
    _ticker?.cancel();
    unawaited(_wall?.cancel());
    unawaited(_sync?.cancel());
    super.dispose();
  }
}
