/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:http/http.dart' as _i85jenna;
import 'package:mehfil_client/src/protocol/album_photo.dart' as _ieq0999k;
import 'package:mehfil_client/src/protocol/delivery_report.dart' as _ixk1n0rf;
import 'package:mehfil_client/src/protocol/event_public.dart' as _ifhlhakq;
import 'package:mehfil_client/src/protocol/host_event.dart' as _icm8qwqy;
import 'package:mehfil_client/src/protocol/join_result.dart' as _irlg4yly;
import 'package:mehfil_client/src/protocol/judge_sample.dart' as _igh23cgb;
import 'package:mehfil_client/src/protocol/reveal_log.dart' as _irqmjged;
import 'package:mehfil_client/src/protocol/roll.dart' as _iji2aijh;
import 'package:mehfil_client/src/protocol/roll_draft.dart' as _i4s7sdo1;
import 'package:mehfil_client/src/protocol/shot_ack.dart' as _ih4mlnjh;
import 'package:mehfil_client/src/protocol/wall.dart' as _ia60iqw9;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart'
    as _ipulbpi2;
import 'protocol.dart' as _il2as5qe;
import 'sync_tables.dart' as _ii3f3u05;
import 'package:mehfil_client/migrations/migration_registry.dart';

/// Serves photo files, and only after their roll is revealed, and only to the
/// event's guests and host. Photos live in private storage, so there is no
/// URL to guess before this check passes.
/// {@category Endpoint}
class EndpointAlbum extends _isc.EndpointRef {
  EndpointAlbum(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'album';

  _ida.Future<_idt.ByteData> photo(
    _isc.UuidValue shotId, {
    required bool thumb,
  }) => caller.callServerEndpoint<_idt.ByteData>(
    'album',
    'photo',
    {
      'shotId': shotId,
      'thumb': thumb,
    },
  );
}

/// Guests sign in with no account: the anonymous provider, gated by the
/// event's join code (see `server.dart`).
/// {@category Endpoint}
class EndpointAnonymousIdp extends _iaic.EndpointAnonymousIdpBase {
  EndpointAnonymousIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'anonymousIdp';

  /// Creates a new anonymous account and returns its session.
  ///
  /// Invokes the [AnonymousIdp.beforeAnonymousAccount] callback if configured,
  /// which may prevent account creation if the endpoint is protected.
  @override
  _ida.Future<_iacc.AuthSuccess> login({String? token}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'anonymousIdp',
        'login',
        {'token': token},
      );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// What the host (the couple, the family) can do: create the event, set the
/// rolls and reveal times, and open a roll early.
/// {@category Endpoint}
class EndpointEvents extends _isc.EndpointRef {
  EndpointEvents(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'events';

  _ida.Future<_icm8qwqy.HostEvent> createEvent(
    String name,
    List<_i4s7sdo1.RollDraft> rolls, {
    required bool isDemo,
    String? hostedBy,
  }) => caller.callServerEndpoint<_icm8qwqy.HostEvent>(
    'events',
    'createEvent',
    {
      'name': name,
      'rolls': rolls,
      'isDemo': isDemo,
      'hostedBy': hostedBy,
    },
  );

  _ida.Future<List<_icm8qwqy.HostEvent>> myEvents() =>
      caller.callServerEndpoint<List<_icm8qwqy.HostEvent>>(
        'events',
        'myEvents',
        {},
      );

  _ida.Future<_icm8qwqy.HostEvent> addRoll(
    int eventId,
    _i4s7sdo1.RollDraft draft,
  ) => caller.callServerEndpoint<_icm8qwqy.HostEvent>(
    'events',
    'addRoll',
    {
      'eventId': eventId,
      'draft': draft,
    },
  );

  /// Moves a reveal: cancels the scheduled call by its identifier and books a
  /// new one. A roll that is already open stays open.
  _ida.Future<_iji2aijh.Roll> setRevealTime(
    int rollId,
    DateTime revealAt,
  ) => caller.callServerEndpoint<_iji2aijh.Roll>(
    'events',
    'setRevealTime',
    {
      'rollId': rollId,
      'revealAt': revealAt,
    },
  );

  /// Opens a roll now (for a host in a hurry, and for judges).
  _ida.Future<_iji2aijh.Roll> revealNow(int rollId) =>
      caller.callServerEndpoint<_iji2aijh.Roll>(
        'events',
        'revealNow',
        {'rollId': rollId},
      );

  /// The revealed album, for the host's screen (to look through and to remove
  /// a photo). Hidden rolls return nothing, the same rule guests get.
  _ida.Future<List<_ieq0999k.AlbumPhoto>> album(int eventId) =>
      caller.callServerEndpoint<List<_ieq0999k.AlbumPhoto>>(
        'events',
        'album',
        {'eventId': eventId},
      );

  /// Removes a photo for everyone (the host's privacy control). The receipt
  /// stays, marked removed, so the delivery evidence still shows it arrived;
  /// the files are deleted and the album copy leaves every phone on next sync.
  _ida.Future<void> removePhoto(_isc.UuidValue shotId) =>
      caller.callServerEndpoint<void>(
        'events',
        'removePhoto',
        {'shotId': shotId},
      );

  /// Rows (offline sync) and files (uploads) the server holds, per guest.
  _ida.Future<_ixk1n0rf.DeliveryReport> delivery(int eventId) =>
      caller.callServerEndpoint<_ixk1n0rf.DeliveryReport>(
        'events',
        'delivery',
        {'eventId': eventId},
      );

  /// Every reveal of the event, with what triggered it and the server time.
  _ida.Future<List<_irqmjged.RevealLog>> reveals(int eventId) =>
      caller.callServerEndpoint<List<_irqmjged.RevealLog>>(
        'events',
        'reveals',
        {'eventId': eventId},
      );
}

/// The guest side of an event: open the QR link, give a name, see the rolls.
/// Nothing here returns a photo.
/// {@category Endpoint}
class EndpointGuest extends _isc.EndpointRef {
  EndpointGuest(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'guest';

  /// The server's clock. Phones use it for countdowns; their own clock is
  /// never trusted for the reveal.
  _ida.Future<DateTime> now() => caller.callServerEndpoint<DateTime>(
    'guest',
    'now',
    {},
  );

  /// Public: what the QR link shows before sign-in. Names and times only.
  _ida.Future<_ifhlhakq.EventPublic> event(String joinCode) =>
      caller.callServerEndpoint<_ifhlhakq.EventPublic>(
        'guest',
        'event',
        {'joinCode': joinCode},
      );

  /// Joins (or re-joins) the event under [name]. Needs the anonymous sign-in
  /// that the QR page did first.
  _ida.Future<_irlg4yly.JoinResult> join(
    String joinCode,
    String name,
  ) => caller.callServerEndpoint<_irlg4yly.JoinResult>(
    'guest',
    'join',
    {
      'joinCode': joinCode,
      'name': name,
    },
  );

  /// Gets a guest whose session was lost back in, as the same person: same
  /// account, same queued photos, same name on the album. The phone proves it
  /// is that guest with the recovery key it got when it first joined.
  _ida.Future<_iacc.AuthSuccess> recover(
    String joinCode,
    int guestId,
    String recoveryKey,
  ) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'guest',
    'recover',
    {
      'joinCode': joinCode,
      'guestId': guestId,
      'recoveryKey': recoveryKey,
    },
  );

  /// The shot ids the server already has from this guest. The phone uses it
  /// to clear its queue after a reinstall or a lost reply.
  _ida.Future<List<_isc.UuidValue>> delivered(int eventId) =>
      caller.callServerEndpoint<List<_isc.UuidValue>>(
        'guest',
        'delivered',
        {'eventId': eventId},
      );
}

/// Powers the "Try to break it" page. Only demo events answer, and the answer
/// is an id, never a photo: the point is to show the server refusing.
/// {@category Endpoint}
class EndpointJudge extends _isc.EndpointRef {
  EndpointJudge(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'judge';

  _ida.Future<_igh23cgb.JudgeSample?> hiddenSample(String joinCode) =>
      caller.callServerEndpoint<_igh23cgb.JudgeSample?>(
        'judge',
        'hiddenSample',
        {'joinCode': joinCode},
      );
}

/// Receives photos from the phone's queue. A shot counts as delivered only
/// when its file is in private storage, its hash matched, and its receipt row
/// is written. Retries are safe: the same shot id is stored once.
/// {@category Endpoint}
class EndpointShot extends _isc.EndpointRef {
  EndpointShot(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'shot';

  _ida.Future<_ih4mlnjh.ShotAck> upload({
    required _isc.UuidValue shotId,
    required int rollId,
    required DateTime takenAt,
    required String sha256Hex,
    required _idt.ByteData bytes,
  }) => caller.callServerEndpoint<_ih4mlnjh.ShotAck>(
    'shot',
    'upload',
    {
      'shotId': shotId,
      'rollId': rollId,
      'takenAt': takenAt,
      'sha256Hex': sha256Hex,
      'bytes': bytes,
    },
  );
}

/// The live wall: counts that climb as photos land, over a WebSocket stream.
/// Anyone with the join code may watch it, because it carries no photos.
/// {@category Endpoint}
class EndpointWall extends _isc.EndpointRef {
  EndpointWall(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'wall';

  /// Sends a fresh snapshot now, on every event tick, and every few seconds
  /// (shot rows arriving through offline sync change the "on phones" count).
  _ida.Stream<_ia60iqw9.WallSnapshot> watch(String joinCode) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ia60iqw9.WallSnapshot>,
        _ia60iqw9.WallSnapshot
      >(
        'wall',
        'watch',
        {'joinCode': joinCode},
        {},
      );

  _ida.Future<_ia60iqw9.WallSnapshot> snapshot(String joinCode) =>
      caller.callServerEndpoint<_ia60iqw9.WallSnapshot>(
        'wall',
        'snapshot',
        {'joinCode': joinCode},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    offline_sync = _ipulbpi2.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _ipulbpi2.Caller offline_sync;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    album = EndpointAlbum(this);
    anonymousIdp = EndpointAnonymousIdp(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    events = EndpointEvents(this);
    guest = EndpointGuest(this);
    judge = EndpointJudge(this);
    shot = EndpointShot(this);
    wall = EndpointWall(this);
    modules = Modules(this);
  }

  late final EndpointAlbum album;

  late final EndpointAnonymousIdp anonymousIdp;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointEvents events;

  late final EndpointGuest guest;

  late final EndpointJudge judge;

  late final EndpointShot shot;

  late final EndpointWall wall;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'album': album,
    'anonymousIdp': anonymousIdp,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'events': events,
    'guest': guest,
    'judge': judge,
    'shot': shot,
    'wall': wall,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'offline_sync': modules.offline_sync,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };

  /// Creates a new client-side database session for the given path.
  ///
  /// The [path] is the file path to the SQLite database file. Since SQLite uses
  /// WAL mode, note that `[path]-shm` and `[path]-wal` files might also exist
  /// transiently for the database while the session is open.
  ///
  /// If [runMigrations] is true, pending migrations will be applied when
  /// opening the database. Be careful when setting this to false, as it might
  /// lead to inconsistencies between the models and the database.
  ///
  /// If [isDebugMode] is true, the database integrity will be verified after
  /// the migrations are applied to provide feedback of possible issues. On a
  /// Flutter application, this should be set to [kDebugMode].
  _ida.Future<_isd.ClientDatabaseSession> createSession(
    String path, {
    bool runMigrations = true,
    bool isDebugMode = false,
  }) async {
    return await _isd.ClientDatabaseSession.open(
      path,
      _il2as5qe.Protocol(),
      clientMigrations: MigrationRegistry.migrations,
      runMigrations: runMigrations,
      isDebugMode: isDebugMode,
    );
  }

  /// Creates a new client-side database session for the given path, wrapped
  /// with the `serverpod_offline_sync` engine for the tables declared with
  /// `database: sync`. See [createSession] for the [path], [runMigrations] and
  /// [isDebugMode] parameters.
  ///
  /// The [persistentUserId] is the user all local operations belong to. When
  /// omitted, the user must be passed through the transaction.
  _ida.Future<_ipulbpi2.OfflineSyncDatabaseSession> createSyncSession(
    String path, {
    bool runMigrations = true,
    bool isDebugMode = false,
    _isc.UuidValue? persistentUserId,
  }) async {
    final session = _ipulbpi2.OfflineSyncDatabaseSession.wraps(
      await createSession(
        path,
        runMigrations: runMigrations,
        isDebugMode: isDebugMode,
      ),
      syncTables: _ii3f3u05.syncTables,
      persistentUserId: persistentUserId,
    );
    await session.db.initialize();
    return session;
  }
}
