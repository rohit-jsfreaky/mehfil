import 'package:serverpod_auth_idp_server/providers/anonymous.dart';

/// Guests sign in with no account: the anonymous provider, gated by the
/// event's join code (see `server.dart`).
class AnonymousIdpEndpoint extends AnonymousIdpBaseEndpoint {}
