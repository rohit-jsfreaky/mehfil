import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mehfil_client/mehfil_client.dart';

import '../ui/format.dart';
import '../ui/icons.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';
import 'guest_session.dart';

/// The disposable camera. Black like every camera app: a live viewfinder in
/// the app, shots left on the left, the shutter in the middle, your shots on
/// the right, and one honest line about what is still on the phone.
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.session, required this.onClose});
  final GuestSession session;
  final VoidCallback onClose;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _cam;
  List<CameraDescription> _cameras = const [];
  int _cameraIndex = 0;
  String? _camError;
  bool _saving = false;
  bool _flash = false;
  double _zoom = 1;
  double _maxZoom = 1;
  int? _rollId;
  bool _savedToast = false;
  Timer? _toastTimer;
  late final Timer _clock;

  GuestSession get s => widget.session;

  Roll? get _roll {
    final open = s.rolls.where((r) => r.revealedAt == null).toList();
    if (open.isEmpty) return null;
    return open.firstWhere((r) => r.id == _rollId, orElse: () => open.first);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    s.addListener(_changed);
    _clock = Timer.periodic(const Duration(seconds: 1), (_) => _changed());
    _startCamera();
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  Future<void> _startCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) throw CameraException('none', 'No camera found');
      final back = _cameras.indexWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
      );
      _cameraIndex = back >= 0 ? back : 0;
      await _open(_cameras[_cameraIndex]);
    } catch (e) {
      if (mounted) {
        setState(
          () =>
              _camError = e is CameraException && e.code.contains('Permission')
              ? 'Camera permission is off for this site.'
              : 'The live camera is not available here.',
        );
      }
    }
  }

  Future<void> _open(CameraDescription description) async {
    final old = _cam;
    _cam = null;
    if (mounted) setState(() {});
    await old?.dispose();
    final cam = CameraController(
      description,
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await cam.initialize();
    try {
      await cam.setFlashMode(FlashMode.off);
    } catch (_) {}
    double maxZoom = 1;
    try {
      maxZoom = await cam.getMaxZoomLevel();
    } catch (_) {}
    if (!mounted) {
      await cam.dispose();
      return;
    }
    setState(() {
      _cam = cam;
      _camError = null;
      _zoom = 1;
      _maxZoom = maxZoom;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cam = _cam;
    if (state == AppLifecycleState.inactive && cam != null) {
      _cam = null;
      cam.dispose();
    } else if (state == AppLifecycleState.resumed &&
        _cam == null &&
        _cameras.isNotEmpty) {
      _open(_cameras[_cameraIndex]);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _clock.cancel();
    _toastTimer?.cancel();
    s.removeListener(_changed);
    _cam?.dispose();
    super.dispose();
  }

  Future<void> _shoot() async {
    final roll = _roll;
    if (roll == null || _saving || s.shotsLeft(roll) <= 0) return;
    setState(() => _saving = true);
    try {
      final Uint8List bytes;
      final cam = _cam;
      if (cam != null && cam.value.isInitialized) {
        bytes = await (await cam.takePicture()).readAsBytes();
      } else {
        final file = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 2048,
          maxHeight: 2048,
          imageQuality: 82,
        );
        if (file == null) return;
        bytes = await file.readAsBytes();
      }
      await s.capture(bytes, roll: roll);
      _toastTimer?.cancel();
      setState(() => _savedToast = true);
      _toastTimer = Timer(const Duration(milliseconds: 1600), () {
        if (mounted) setState(() => _savedToast = false);
      });
    } catch (e) {
      if (mounted) toast(context, friendlyError(e));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _flip() async {
    if (_cameras.length < 2) return;
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;
    try {
      await _open(_cameras[_cameraIndex]);
    } catch (e) {
      if (mounted) toast(context, friendlyError(e));
    }
  }

  Future<void> _toggleFlash() async {
    final cam = _cam;
    if (cam == null) return;
    try {
      await cam.setFlashMode(_flash ? FlashMode.off : FlashMode.always);
      setState(() => _flash = !_flash);
    } catch (_) {
      if (mounted) {
        toast(context, 'This phone has no flash for the web camera.');
      }
    }
  }

  Future<void> _setZoom(double z) async {
    final cam = _cam;
    if (cam == null) return;
    try {
      await cam.setZoomLevel(z);
      setState(() => _zoom = z);
    } catch (_) {}
  }

  Future<void> _pickRoll() async {
    final open = s.rolls.where((r) => r.revealedAt == null).toList();
    if (open.length < 2) return;
    final picked = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: M.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (c) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(M.margin, 12, M.margin, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: M.line,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Caps('Shoot for'),
              const SizedBox(height: 4),
              for (final r in open)
                InfoRow(
                  icon: Ph.filmStrip,
                  title: Text(r.name),
                  subtitle:
                      '${s.shotsLeft(r)} shots left · opens ${revealLabel(r.revealAt)}',
                  trailing: r.id == _roll?.id
                      ? const Icon(Ph.check, color: M.ink)
                      : null,
                  onTap: () => Navigator.of(c).pop(r.id),
                ),
            ],
          ),
        ),
      ),
    );
    if (picked != null) setState(() => _rollId = picked);
  }

  @override
  Widget build(BuildContext context) {
    final roll = _roll;
    final left = roll == null ? 0 : s.shotsLeft(roll);
    final mine = roll == null ? 0 : (s.shotsByRoll[roll.id] ?? 0);
    return Scaffold(
      backgroundColor: M.camBg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 14),
              child: Column(
                children: [
                  _topBar(roll),
                  const SizedBox(height: 10),
                  Expanded(child: _viewfinder(roll)),
                  const SizedBox(height: 18),
                  _controls(left, mine, roll),
                  const SizedBox(height: 14),
                  _statusLine(roll),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar(Roll? roll) {
    return Row(
      children: [
        IconBtn(
          icon: Ph.x,
          label: 'Close camera',
          dark: true,
          onTap: widget.onClose,
        ),
        Expanded(
          child: GestureDetector(
            onTap: _pickRoll,
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Text(
                  s.event.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: M.headline.copyWith(fontSize: 15, color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      roll?.name ?? 'All open',
                      style: M.footnote.copyWith(color: M.camMuted),
                    ),
                    if (s.rolls.where((r) => r.revealedAt == null).length >
                        1) ...[
                      const SizedBox(width: 4),
                      const Icon(Ph.caretDown, size: 12, color: M.camMuted),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
        IconBtn(
          icon: _flash ? Ph.lightning : Ph.lightningSlash,
          label: _flash ? 'Flash on' : 'Flash off',
          dark: true,
          onTap: _cam == null ? null : _toggleFlash,
        ),
      ],
    );
  }

  Widget _viewfinder(Roll? roll) {
    final cam = _cam;
    Widget inner;
    if (roll == null) {
      inner = Center(
        child: Text(
          'Every function is open.\nEnjoy the album!',
          textAlign: TextAlign.center,
          style: M.body.copyWith(color: M.camMuted),
        ),
      );
    } else if (cam != null && cam.value.isInitialized) {
      // Native cameras report a landscape size for a portrait preview; the
      // web camera reports the video's real width and height.
      final size = cam.value.previewSize ?? const Size(1920, 1080);
      inner = FittedBox(
        fit: BoxFit.cover,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: kIsWeb ? size.width : size.height,
          height: kIsWeb ? size.height : size.width,
          child: cam.buildPreview(),
        ),
      );
    } else if (_camError != null) {
      inner = Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Ph.camera, size: 32, color: M.camMuted),
            const SizedBox(height: 12),
            Text(
              _camError!,
              textAlign: TextAlign.center,
              style: M.body.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              'You can still shoot with your phone camera.',
              textAlign: TextAlign.center,
              style: M.footnote.copyWith(color: M.camMuted),
            ),
          ],
        ),
      );
    } else {
      inner = const Center(
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Container(
        color: const Color(0xFF26262A),
        child: Stack(
          fit: StackFit.expand,
          children: [
            inner,
            if (!s.online)
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Ph.wifiSlash, size: 16, color: M.ink),
                        const SizedBox(width: 6),
                        Text(
                          'No signal · keep shooting',
                          style: M.footnote.copyWith(
                            color: M.ink,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 180),
              bottom: _savedToast ? 76 : 60,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: _savedToast ? 1 : 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x99000000),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Ph.check, size: 15, color: M.camOk),
                          const SizedBox(width: 6),
                          Text(
                            'Saved on this phone',
                            style: M.footnote.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (cam != null && cam.value.isInitialized)
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Row(
                  children: [
                    if (_cameras.length > 1)
                      _glassButton(Ph.arrowsClockwise, 'Switch camera', _flip)
                    else
                      const SizedBox(width: 40),
                    const Spacer(),
                    if (_maxZoom >= 2)
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0x73000000),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Row(
                          children: [
                            for (final z in [1.0, 2.0])
                              GestureDetector(
                                onTap: () => _setZoom(z),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _zoom == z
                                        ? Colors.white
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    z == 1 ? '1×' : '2',
                                    style: M.number(
                                      12,
                                      color: _zoom == z
                                          ? Colors.black
                                          : const Color(0xFFD4D4D8),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _glassButton(IconData icon, String label, VoidCallback onTap) =>
      Semantics(
        button: true,
        label: label,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0x73000000),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: Colors.white),
          ),
        ),
      );

  Widget _controls(int left, int mine, Roll? roll) {
    final canShoot = roll != null && left > 0 && !_saving;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          SizedBox(
            width: 76,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$left', style: M.number(28, color: Colors.white)),
                Text(
                  'shots left',
                  style: M.footnote.copyWith(color: M.camMuted),
                ),
              ],
            ),
          ),
          const Spacer(),
          Semantics(
            button: true,
            label: 'Take a photo',
            enabled: canShoot,
            child: GestureDetector(
              onTap: canShoot ? _shoot : null,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 120),
                opacity: canShoot || _saving ? 1 : 0.35,
                child: Container(
                  width: 84,
                  height: 84,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 90),
                    margin: EdgeInsets.all(_saving ? 6 : 0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 76,
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 48,
                height: 56,
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 40,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A3A40),
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        width: 42,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: M.camPanel,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                            color: const Color(0xFF52525B),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          '$mine',
                          style: M.number(16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusLine(Roll? roll) {
    final (IconData icon, Color color, String text) = switch ((
      s.waiting,
      s.online,
    )) {
      (0, _) when s.delivered == 0 => (
        Ph.camera,
        M.camMuted,
        roll == null
            ? 'Nothing left to shoot'
            : '${roll.name} opens for everyone ${revealLabel(roll.revealAt)}',
      ),
      (0, _) => (
        Ph.check,
        M.camOk,
        'Your ${plural(s.delivered, 'photo')} ${s.delivered == 1 ? 'is' : 'are'} sent'
            '${roll == null ? '' : ' · ${roll.name} opens ${revealLabel(roll.revealAt)}'}',
      ),
      (_, false) => (
        Ph.clock,
        const Color(0xFFD4D4D8),
        '${plural(s.waiting, 'photo')} on this phone · ${s.waiting == 1 ? 'it sends' : 'they send'} when signal returns',
      ),
      (_, true) => (
        Ph.cloudArrowUp,
        const Color(0xFFD4D4D8),
        'Sending ${plural(s.waiting, 'photo')}…',
      ),
    };
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: M.footnote.copyWith(color: const Color(0xFFD4D4D8)),
          ),
        ),
      ],
    );
  }
}
