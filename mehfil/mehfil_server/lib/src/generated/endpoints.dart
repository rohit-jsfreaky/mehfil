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
import 'dart:typed_data' as _idt;
import 'package:mehfil_server/src/generated/future_calls.dart' as _ist9ghf2;
import 'package:mehfil_server/src/generated/roll_draft.dart' as _i5yo6dyh;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:serverpod_offline_sync_server/serverpod_offline_sync_server.dart'
    as _izehhkf5;
import '../album/album_endpoint.dart' as _intufifq;
import '../auth/anonymous_idp_endpoint.dart' as _in0zita6;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../events/events_endpoint.dart' as _iwysfsn2;
import '../events/guest_endpoint.dart' as _ir9fyn4w;
import '../judges/judge_endpoint.dart' as _iclqfi2z;
import '../shots/shot_endpoint.dart' as _ipqvmsab;
import '../wall/wall_endpoint.dart' as _i3ga9frd;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'album': _intufifq.AlbumEndpoint()
        ..initialize(
          server,
          'album',
          null,
        ),
      'anonymousIdp': _in0zita6.AnonymousIdpEndpoint()
        ..initialize(
          server,
          'anonymousIdp',
          null,
        ),
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'events': _iwysfsn2.EventsEndpoint()
        ..initialize(
          server,
          'events',
          null,
        ),
      'guest': _ir9fyn4w.GuestEndpoint()
        ..initialize(
          server,
          'guest',
          null,
        ),
      'judge': _iclqfi2z.JudgeEndpoint()
        ..initialize(
          server,
          'judge',
          null,
        ),
      'shot': _ipqvmsab.ShotEndpoint()
        ..initialize(
          server,
          'shot',
          null,
        ),
      'wall': _i3ga9frd.WallEndpoint()
        ..initialize(
          server,
          'wall',
          null,
        ),
    };
    connectors['album'] = _is.EndpointConnector(
      name: 'album',
      endpoint: endpoints['album']!,
      methodConnectors: {
        'photo': _is.MethodConnector(
          name: 'photo',
          params: {
            'shotId': _is.ParameterDescription(
              name: 'shotId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'thumb': _is.ParameterDescription(
              name: 'thumb',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['album'] as _intufifq.AlbumEndpoint).photo(
                session,
                params['shotId'],
                thumb: params['thumb'],
              ),
        ),
      },
    );
    connectors['anonymousIdp'] = _is.EndpointConnector(
      name: 'anonymousIdp',
      endpoint: endpoints['anonymousIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['anonymousIdp'] as _in0zita6.AnonymousIdpEndpoint)
                      .login(
                        session,
                        token: params['token'],
                      ),
        ),
      },
    );
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['events'] = _is.EndpointConnector(
      name: 'events',
      endpoint: endpoints['events']!,
      methodConnectors: {
        'createEvent': _is.MethodConnector(
          name: 'createEvent',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'rolls': _is.ParameterDescription(
              name: 'rolls',
              type: _is.getType<List<_i5yo6dyh.RollDraft>>(),
              nullable: false,
            ),
            'isDemo': _is.ParameterDescription(
              name: 'isDemo',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'hostedBy': _is.ParameterDescription(
              name: 'hostedBy',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['events'] as _iwysfsn2.EventsEndpoint).createEvent(
                    session,
                    params['name'],
                    params['rolls'],
                    isDemo: params['isDemo'],
                    hostedBy: params['hostedBy'],
                  ),
        ),
        'myEvents': _is.MethodConnector(
          name: 'myEvents',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['events'] as _iwysfsn2.EventsEndpoint)
                  .myEvents(session),
        ),
        'addRoll': _is.MethodConnector(
          name: 'addRoll',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'draft': _is.ParameterDescription(
              name: 'draft',
              type: _is.getType<_i5yo6dyh.RollDraft>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['events'] as _iwysfsn2.EventsEndpoint).addRoll(
                    session,
                    params['eventId'],
                    params['draft'],
                  ),
        ),
        'setRevealTime': _is.MethodConnector(
          name: 'setRevealTime',
          params: {
            'rollId': _is.ParameterDescription(
              name: 'rollId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'revealAt': _is.ParameterDescription(
              name: 'revealAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['events'] as _iwysfsn2.EventsEndpoint)
                  .setRevealTime(
                    session,
                    params['rollId'],
                    params['revealAt'],
                  ),
        ),
        'revealNow': _is.MethodConnector(
          name: 'revealNow',
          params: {
            'rollId': _is.ParameterDescription(
              name: 'rollId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['events'] as _iwysfsn2.EventsEndpoint).revealNow(
                    session,
                    params['rollId'],
                  ),
        ),
        'album': _is.MethodConnector(
          name: 'album',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['events'] as _iwysfsn2.EventsEndpoint).album(
                    session,
                    params['eventId'],
                  ),
        ),
        'removePhoto': _is.MethodConnector(
          name: 'removePhoto',
          params: {
            'shotId': _is.ParameterDescription(
              name: 'shotId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['events'] as _iwysfsn2.EventsEndpoint).removePhoto(
                    session,
                    params['shotId'],
                  ),
        ),
        'delivery': _is.MethodConnector(
          name: 'delivery',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['events'] as _iwysfsn2.EventsEndpoint).delivery(
                    session,
                    params['eventId'],
                  ),
        ),
        'reveals': _is.MethodConnector(
          name: 'reveals',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['events'] as _iwysfsn2.EventsEndpoint).reveals(
                    session,
                    params['eventId'],
                  ),
        ),
      },
    );
    connectors['guest'] = _is.EndpointConnector(
      name: 'guest',
      endpoint: endpoints['guest']!,
      methodConnectors: {
        'now': _is.MethodConnector(
          name: 'now',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['guest'] as _ir9fyn4w.GuestEndpoint).now(session),
        ),
        'event': _is.MethodConnector(
          name: 'event',
          params: {
            'joinCode': _is.ParameterDescription(
              name: 'joinCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guest'] as _ir9fyn4w.GuestEndpoint).event(
                session,
                params['joinCode'],
              ),
        ),
        'join': _is.MethodConnector(
          name: 'join',
          params: {
            'joinCode': _is.ParameterDescription(
              name: 'joinCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guest'] as _ir9fyn4w.GuestEndpoint).join(
                session,
                params['joinCode'],
                params['name'],
              ),
        ),
        'delivered': _is.MethodConnector(
          name: 'delivered',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['guest'] as _ir9fyn4w.GuestEndpoint).delivered(
                    session,
                    params['eventId'],
                  ),
        ),
      },
    );
    connectors['judge'] = _is.EndpointConnector(
      name: 'judge',
      endpoint: endpoints['judge']!,
      methodConnectors: {
        'hiddenSample': _is.MethodConnector(
          name: 'hiddenSample',
          params: {
            'joinCode': _is.ParameterDescription(
              name: 'joinCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['judge'] as _iclqfi2z.JudgeEndpoint).hiddenSample(
                    session,
                    params['joinCode'],
                  ),
        ),
      },
    );
    connectors['shot'] = _is.EndpointConnector(
      name: 'shot',
      endpoint: endpoints['shot']!,
      methodConnectors: {
        'upload': _is.MethodConnector(
          name: 'upload',
          params: {
            'shotId': _is.ParameterDescription(
              name: 'shotId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'rollId': _is.ParameterDescription(
              name: 'rollId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'takenAt': _is.ParameterDescription(
              name: 'takenAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'sha256Hex': _is.ParameterDescription(
              name: 'sha256Hex',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'bytes': _is.ParameterDescription(
              name: 'bytes',
              type: _is.getType<_idt.ByteData>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['shot'] as _ipqvmsab.ShotEndpoint).upload(
                session,
                shotId: params['shotId'],
                rollId: params['rollId'],
                takenAt: params['takenAt'],
                sha256Hex: params['sha256Hex'],
                bytes: params['bytes'],
              ),
        ),
      },
    );
    connectors['wall'] = _is.EndpointConnector(
      name: 'wall',
      endpoint: endpoints['wall']!,
      methodConnectors: {
        'snapshot': _is.MethodConnector(
          name: 'snapshot',
          params: {
            'joinCode': _is.ParameterDescription(
              name: 'joinCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['wall'] as _i3ga9frd.WallEndpoint).snapshot(
                session,
                params['joinCode'],
              ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'joinCode': _is.ParameterDescription(
              name: 'joinCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['wall'] as _i3ga9frd.WallEndpoint).watch(
                session,
                params['joinCode'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_offline_sync'] = _izehhkf5.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _ist9ghf2.FutureCalls();
  }
}
