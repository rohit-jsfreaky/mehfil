import 'package:flutter/material.dart';

import '../ui/icons.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';
import 'album_screen.dart';
import 'camera_screen.dart';
import 'event_tab.dart';
import 'guest_session.dart';

/// The guest's app: Camera (full screen, black), Event and Album (light,
/// with the floating tab bar). Opens on the camera: the guest came to shoot.
class GuestShell extends StatefulWidget {
  const GuestShell({super.key, required this.session});
  final GuestSession session;

  @override
  State<GuestShell> createState() => _GuestShellState();
}

class _GuestShellState extends State<GuestShell> {
  int _tab = 0;

  static const _items = [
    TabItem('Camera', Ph.camera, Ph.cameraFill),
    TabItem('Event', Ph.calendarBlank, Ph.calendarBlankFill),
    TabItem('Album', Ph.images, Ph.imagesFill),
  ];

  void _go(int i) => setState(() => _tab = i);

  @override
  Widget build(BuildContext context) {
    if (_tab == 0) {
      return CameraScreen(session: widget.session, onClose: () => _go(1));
    }
    return Scaffold(
      backgroundColor: M.bg,
      body: Stack(
        children: [
          Positioned.fill(
            child: _tab == 1
                ? EventTab(
                    session: widget.session,
                    onOpenCamera: () => _go(0),
                    onOpenAlbum: () => _go(2),
                  )
                : AlbumScreen(session: widget.session),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: SafeArea(
              top: false,
              child: Center(
                child: FloatingTabs(items: _items, index: _tab, onSelect: _go),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
