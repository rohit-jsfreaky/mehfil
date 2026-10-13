import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

/// The judges' demo host login. Real hosts sign up with an emailed code; a
/// judge can't receive that code, so the server keeps one ready-made host
/// account whose email and password come from two server passwords
/// (`demoHostEmail`, `demoHostPassword` — on Serverpod Cloud:
/// `serverpod cloud password set ...`). Without them this does nothing.
abstract final class DemoHost {
  static Future<void> ensure(Serverpod pod) async {
    final email = pod.getPassword('demoHostEmail');
    final password = pod.getPassword('demoHostPassword');
    if (email == null ||
        email.isEmpty ||
        password == null ||
        password.isEmpty) {
      return;
    }

    final session = await pod.createSession(enableLogging: false);
    try {
      final admin = AuthServices.instance.emailIdp.admin;
      await session.db.transaction((tx) async {
        final account = await admin.findAccount(
          session,
          email: email,
          transaction: tx,
        );
        if (account != null) {
          // Keeps the published password working if it was changed.
          await admin.setPassword(
            session,
            email: email,
            password: password,
            transaction: tx,
          );
          return;
        }
        final user = await AuthServices.instance.authUsers.create(
          session,
          transaction: tx,
        );
        await admin.createEmailAuthentication(
          session,
          authUserId: user.id,
          email: email,
          password: password,
          transaction: tx,
        );
      });
      stdout.writeln('Demo host login ready: $email');
    } catch (e) {
      stderr.writeln('Demo host login not created: $e');
    } finally {
      await session.close();
    }
  }
}
