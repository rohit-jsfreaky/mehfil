import 'package:flutter/material.dart';

import 'client.dart';
import 'guest/join_screen.dart';
import 'host/host_home.dart';
import 'judges/try_screen.dart';
import 'ui/theme.dart';
import 'wall/wall_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  await loadHostMode();
  runApp(const MehfilApp());
}

class MehfilApp extends StatelessWidget {
  const MehfilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mehfil',
      debugShowCheckedModeBanner: false,
      theme: M.theme(),
      darkTheme: M.theme(),
      themeMode: ThemeMode.dark,
      home: _routeFor(Uri.base),
    );
  }

  /// Web links: /e/CODE (a guest's QR), /wall/CODE (the couple's TV),
  /// /try/CODE (judges try to break the hiding on a demo event).
  /// Everything else is the host's front door.
  static Widget _routeFor(Uri uri) {
    final parts = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    if (parts.length == 2 && parts[0] == 'e') {
      return JoinScreen(code: parts[1].toUpperCase());
    }
    if (parts.length == 2 && parts[0] == 'wall') {
      return WallScreen(code: parts[1].toUpperCase());
    }
    if (parts.length == 2 && parts[0] == 'try') {
      return TryScreen(code: parts[1].toUpperCase());
    }
    return const HostHome();
  }
}
