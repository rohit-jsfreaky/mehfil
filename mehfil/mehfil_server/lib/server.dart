import 'dart:io';

import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/anonymous.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_cloud_storage/serverpod_cloud_storage.dart';

import 'src/auth/demo_host.dart';
import 'src/cache_busting.dart';
import 'src/core/access.dart';
import 'src/generated/serverpod.dart';
import 'src/generated/protocol.dart';
import 'src/reveal/reveal_clock.dart';
import 'src/reveal/reveal_service.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/gzip_wasm_route.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod. The generated Serverpod class is already connected
  // with your project's generated code.
  final pod = Serverpod(args);

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password authentication.
      // The default setup works with Serverpod Cloud without configuration. In
      // development the verification codes are logged to the console, and in
      // staging and production they are sent through the Serverpod Cloud email
      // service. If you want to use a custom provider for sending emails, use
      // `EmailIdpConfigFromPasswords`.
      // Hosts sign in with email.
      ServerpodCloudEmailIdpConfig(
        appDisplayName: 'Mehfil',
      ),
      // Guests sign in with no account. The token is the event's join code
      // from the QR, so only people holding a real QR can get a session.
      AnonymousIdpConfig(
        onBeforeAnonymousAccountCreated:
            (
              session, {
              String? token,
              required transaction,
            }) async {
              final code = Access.normalizeCode(token ?? '');
              final event = code.isEmpty
                  ? null
                  : await Event.db.findFirstRow(
                      session,
                      where: (t) => t.joinCode.equals(code),
                      transaction: transaction,
                    );
              if (event == null) {
                throw AnonymousAccountBlockedException(
                  reason: AnonymousAccountBlockedExceptionReason.denied,
                );
              }
            },
        // A whole wedding shares one venue Wi-Fi address.
        perIpAddressRateLimit: const RateLimit(
          maxAttempts: 2000,
          timeframe: Duration(hours: 1),
        ),
      ),
    ],
  );

  // Serve all files in the web/static relative directory under /web.
  // These are used by the default web page.
  pod.webServer.addRoute(
    StaticRoute.withCacheBusting(cacheBustingConfig),
    cacheBustingConfig.mountPrefix,
  );

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(
      apiConfig: pod.config.apiServer,
      webConfig: pod.config.webServer!,
    ),
    '/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // The big wasm files go out gzipped (the CDN only compresses text).
    for (final wasm in [
      'canvaskit/canvaskit.wasm',
      'canvaskit/chromium/canvaskit.wasm',
      'sqlite3.wasm',
    ]) {
      final file = File(Uri(path: 'web/app/$wasm').toFilePath());
      if (file.existsSync()) {
        pod.webServer.addRoute(GzipWasmRoute(file), '/$wasm');
      }
    }

    // Serve the flutter web app under /.
    pod.webServer.addRoute(
      FlutterRoute(
        appDir,
        // If building the Flutter app with WASM, set the below parameter to
        // true and add the --wasm flag to the flutter build command.
        enableWasmHeaders: false,
      ),
      '/',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    final defaultRoute = StaticRoute.file(
      File(
        Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
      ),
    );

    pod.webServer.addMiddleware(
      FallbackMiddleware(
        fallback: defaultRoute,
        on: (response) => response.statusCode == 404,
      ).call,
      '/',
    );

    pod.webServer.addRoute(
      defaultRoute,
      '/**',
    );
  }

  // Configure cloud storage.
  // This setup works with Serverpod Cloud without extra configuration.
  // If you want to use a custom provider for cloud storage, replace these
  // with your preferred provider.
  pod.addCloudStorage(
    await ServerpodCloudProvider.private(
      fallback: () => DatabaseCloudStorage('private'),
    ),
  );
  pod.addCloudStorage(
    await ServerpodCloudProvider.public(
      fallback: () => DatabaseCloudStorage('public'),
    ),
  );

  // Start the server.
  await pod.start();

  // Finish any reveal a crash cut short. Scheduled reveals need nothing here:
  // future calls are stored in the database and survive restarts.
  final session = await pod.createSession(enableLogging: false);
  final bool futureCallsOn;
  try {
    await RevealService.sweep(session);
    futureCallsOn = await RevealService.futureCallsAvailable(session);
  } finally {
    await session.close();
  }

  // Safety net under the future call: opens any reveal that is overdue. Where
  // future calls run, the future call fires first and the clock waits 45 s
  // before stepping in. On Serverpod Cloud's free Starter plan (future calls
  // switched off) the clock is what opens the album, on time.
  RevealClock(
    pod,
    grace: futureCallsOn ? const Duration(seconds: 45) : Duration.zero,
  ).start();
  stdout.writeln(
    futureCallsOn
        ? 'Reveals: future calls, with the reveal clock as a safety net.'
        : 'Reveals: future calls are off here; the reveal clock opens rolls.',
  );
  await DemoHost.ensure(pod);
}
