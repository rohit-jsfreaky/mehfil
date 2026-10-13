import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

/// Serves one of the Flutter web app's big `.wasm` files gzipped.
///
/// Flutter's renderer (`canvaskit.wasm`, 5–7 MB) and SQLite (`sqlite3.wasm`)
/// otherwise go out uncompressed: the CDN compresses text files but not wasm.
/// Gzipped they are well under half the size, which is the difference between
/// a guest waiting 8 seconds and 3 on the first scan of the QR. After that the
/// app's service worker serves them from the phone.
class GzipWasmRoute extends Route {
  GzipWasmRoute(this.file) : super(methods: {Method.get, Method.head}) {
    // Compress once at start-up, so no guest waits for it.
    unawaited(_gzip().catchError((_) => Uint8List(0)));
  }

  final File file;
  Future<Uint8List>? _gzipped;

  Future<Uint8List> _gzip() => _gzipped ??= file
      .readAsBytes()
      .then(
        (bytes) => Isolate.run(
          () => Uint8List.fromList(GZipCodec(level: 9).encode(bytes)),
        ),
      )
      .catchError((Object e) {
        _gzipped = null; // try again on the next request
        throw e;
      });

  static final _cacheControl =
      Platform.environment['SERVERPOD_WEB_SERVER_FLUTTER_CACHE_CONTROL'] ??
      'no-cache';

  @override
  FutureOr<Result> handleCall(Session session, Request request) async {
    // Serverpod Cloud's CDN does not pass the browser's Accept-Encoding on to
    // the server, and every browser that runs Flutter web accepts gzip. So:
    // gzip, unless a client explicitly asks for encodings without it.
    final asked = request.headers['accept-encoding'];
    final acceptsGzip =
        asked == null ||
        asked.isEmpty ||
        asked.any((value) => value.toLowerCase().contains('gzip'));
    final bytes = acceptsGzip ? await _gzip() : await file.readAsBytes();
    return Response.ok(
      body: Body.fromData(
        bytes,
        mimeType: const MimeType('application', 'wasm'),
      ),
      headers: Headers.fromMap({
        'cache-control': [_cacheControl],
        'vary': ['accept-encoding'],
        if (acceptsGzip) 'content-encoding': ['gzip'],
      }),
    );
  }
}
