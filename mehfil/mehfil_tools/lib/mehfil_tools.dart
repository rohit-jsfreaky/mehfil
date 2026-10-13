/// Helpers for scripts that use a running Mehfil server exactly like the app:
/// the generated client, real sign-in, real uploads.
library;

import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;
import 'package:mehfil_client/mehfil_client.dart';

export 'package:mehfil_client/mehfil_client.dart';

/// Sends a fixed bearer token, like the app's session manager does.
class TokenProvider implements ClientAuthKeyProvider {
  TokenProvider(this.token);
  String token;

  @override
  Future<String?> get authHeaderValue async =>
      wrapAsBearerAuthHeaderValue(token);
}

Client connect(String serverUrl) => Client(serverUrl);

/// Signs a host in with email + password. On first use it registers the
/// account; in development the server prints the verification code to its
/// log, which this reads from [serverLog].
Future<UuidValue> signInHost(
  Client client, {
  required String email,
  required String password,
  String? serverLog,
}) async {
  try {
    final ok = await client.emailIdp.login(email: email, password: password);
    client.authKeyProvider = TokenProvider(ok.token);
    return ok.authUserId;
  } catch (_) {
    if (serverLog == null) rethrow;
  }

  final logFile = File(serverLog);
  final before = logFile.lengthSync();
  final requestId = await client.emailIdp.startRegistration(email: email);
  String? code;
  for (var i = 0; i < 40 && code == null; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final raf = logFile.openSync()..setPositionSync(before);
    final tail = String.fromCharCodes(
      raf.readSync(logFile.lengthSync() - before),
    );
    raf.closeSync();
    final match = RegExp(
      'code for ${RegExp.escape(email)}: <([A-Za-z0-9]+)>',
    ).allMatches(tail).lastOrNull;
    code = match?.group(1);
  }
  if (code == null)
    throw StateError('No verification code found in $serverLog');

  final token = await client.emailIdp.verifyRegistrationCode(
    accountRequestId: requestId,
    verificationCode: code,
  );
  final ok = await client.emailIdp.finishRegistration(
    registrationToken: token,
    password: password,
  );
  client.authKeyProvider = TokenProvider(ok.token);
  return ok.authUserId;
}

/// What a guest's phone does after scanning the QR: anonymous sign-in with the
/// join code as the token, then join under a name.
Future<JoinResult> joinAsGuest(Client client, String code, String name) async {
  final ok = await client.anonymousIdp.login(token: code);
  client.authKeyProvider = TokenProvider(ok.token);
  return client.guest.join(code, name);
}

/// A real JPEG (the server decodes it and makes a thumbnail).
ByteData testJpeg(int seed, {int width = 1600, int height = 1200}) {
  final image = img.Image(width: width, height: height);
  for (var y = 0; y < height; y += 40) {
    img.fillRect(
      image,
      x1: 0,
      y1: y,
      x2: width,
      y2: y + 40,
      color: img.ColorRgb8(
        (seed * 53 + y) % 255,
        (seed * 31) % 255,
        (y ~/ 4) % 255,
      ),
    );
  }
  return ByteData.sublistView(img.encodeJpg(image, quality: 82));
}

String sha256Of(ByteData bytes) => sha256
    .convert(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes))
    .toString();

UuidValue newShotId() => UuidValue.fromString(const Uuid().v7());

Future<ShotAck> uploadShot(
  Client client, {
  required int rollId,
  required ByteData bytes,
  UuidValue? shotId,
}) {
  return client.shot.upload(
    shotId: shotId ?? newShotId(),
    rollId: rollId,
    takenAt: DateTime.now().toUtc(),
    sha256Hex: sha256Of(bytes),
    bytes: bytes,
  );
}
