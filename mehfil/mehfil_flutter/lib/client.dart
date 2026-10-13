import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mehfil_client/mehfil_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The one client the app uses to talk to the Mehfil server.
late final Client client;

/// Where guests open the app (the QR codes point here).
late final Uri webUrl;

Future<void> initializeClient() async {
  final apiUrl = await getServerUrl();
  client = Client(apiUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  webUrl = await _webUrl(apiUrl);
  // Restores the saved session from storage; works with no signal.
  try {
    // Restore only. `initialize()` also forces a token refresh, and with
    // rotating refresh tokens two tabs opening at once (the host's page and
    // the live wall) can sign the device out. Tokens refresh lazily instead,
    // when a call needs it. Also works offline.
    await client.auth.restore();
  } catch (_) {}
}

Future<Uri> _webUrl(String apiUrl) async {
  const fromDefine = String.fromEnvironment('WEB_URL');
  if (fromDefine.isNotEmpty) return Uri.parse(fromDefine);
  if (kIsWeb) return Uri.parse(Uri.base.origin);
  try {
    final json = jsonDecode(await rootBundle.loadString('assets/config.json'));
    final web = (json as Map<String, dynamic>)['webUrl'] as String?;
    if (web != null && web.isNotEmpty) return Uri.parse(web);
  } catch (_) {}
  return Uri.parse(apiUrl);
}

/// The link a QR code carries for an event.
Uri joinLink(String joinCode) => webUrl.replace(path: '/e/$joinCode');

/// The link to the live wall for an event.
Uri wallLink(String joinCode) => webUrl.replace(path: '/wall/$joinCode');

/// True when the signed-in user signed in as a host (email) on this device.
/// A guest's anonymous session on the same browser is not a host.
final hostMode = ValueNotifier<bool>(false);

Future<void> loadHostMode() async {
  final prefs = await SharedPreferences.getInstance();
  hostMode.value =
      client.auth.isAuthenticated && (prefs.getBool('mehfil.host') ?? false);
}

Future<void> setHostMode(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('mehfil.host', value);
  hostMode.value = value;
}
