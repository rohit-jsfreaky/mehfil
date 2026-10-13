import 'package:serverpod/serverpod.dart';

class AppConfigWidget extends JsonWidget {
  final String apiUrl;
  final String webUrl;

  AppConfigWidget({
    required this.apiUrl,
    required this.webUrl,
  }) : super(object: {'apiUrl': apiUrl, 'webUrl': webUrl});
}

/// Serves the Flutter web app its API address, and the public web address the
/// host's QR codes point guests to.
class AppConfigRoute extends WidgetRoute {
  AppConfigWidget widget;

  AppConfigRoute({
    required final ServerConfig apiConfig,
    required final ServerConfig webConfig,
  }) : widget = AppConfigWidget(
         apiUrl: apiConfig.publicUrl.toString(),
         webUrl: webConfig.publicUrl.toString(),
       );

  @override
  Future<WebWidget> build(Session session, Request request) async {
    return widget;
  }
}

extension on ServerConfig {
  Uri get publicUrl => Uri(
    scheme: publicScheme,
    host: publicHost,
    port: publicPort,
  );
}
