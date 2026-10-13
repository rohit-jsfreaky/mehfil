import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mehfil_client/mehfil_client.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../client.dart';
import '../ui/format.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';

/// The live wall for the couple's TV: counts that climb as photos land, who
/// just sent what, and the QR to join. Counts only: the server never sends a
/// photo before the reveal.
class WallScreen extends StatefulWidget {
  const WallScreen({super.key, required this.code});
  final String code;

  @override
  State<WallScreen> createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  StreamSubscription<WallSnapshot>? _sub;
  WallSnapshot? _snap;
  Duration _offset = Duration.zero;
  bool _live = false;
  String? _error;
  late final Timer _tick;

  @override
  void initState() {
    super.initState();
    _connect();
    _tick = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  void _connect() {
    _sub = client.wall
        .watch(widget.code)
        .listen(
          (snap) => setState(() {
            _snap = snap;
            _offset = snap.serverNow.difference(DateTime.now().toUtc());
            _live = true;
            _error = null;
          }),
          onError: (Object e) {
            setState(() {
              _live = false;
              if (e is MehfilException) _error = e.message;
            });
            _retry();
          },
          onDone: () {
            if (mounted) setState(() => _live = false);
            _retry();
          },
          cancelOnError: true,
        );
  }

  void _retry() {
    unawaited(_sub?.cancel());
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (mounted) _connect();
    });
  }

  @override
  void dispose() {
    _tick.cancel();
    unawaited(_sub?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final snap = _snap;
    return Scaffold(
      backgroundColor: M.bg,
      body: SafeArea(
        child: snap == null
            ? Center(
                child: _error != null
                    ? Text(_error!, style: M.body)
                    : const CircularProgressIndicator(
                        color: M.ink,
                        strokeWidth: 2,
                      ),
              )
            : LayoutBuilder(
                builder: (context, c) {
                  final wide = c.maxWidth >= 900;
                  final s = (c.maxWidth / 1280).clamp(0.5, 1.6).toDouble();
                  final now = DateTime.now().toUtc().add(_offset);
                  final main = _Main(
                    snap: snap,
                    scale: wide ? s : 0.55,
                    now: now,
                    live: _live,
                  );
                  final side = _Side(snap: snap, code: widget.code, now: now);
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: wide ? 56 * s : 20,
                      vertical: wide ? 48 * s : 16,
                    ),
                    child: wide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: main),
                              SizedBox(width: 56 * s),
                              SizedBox(width: 400, child: side),
                            ],
                          )
                        : ListView(
                            children: [main, const SizedBox(height: 24), side],
                          ),
                  );
                },
              ),
      ),
    );
  }
}

class _Main extends StatelessWidget {
  const _Main({
    required this.snap,
    required this.scale,
    required this.now,
    required this.live,
  });
  final WallSnapshot snap;
  final double scale;
  final DateTime now;
  final bool live;

  @override
  Widget build(BuildContext context) {
    final current = snap.rolls.where((r) => r.revealedAt == null).firstOrNull;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: live ? M.accent : M.ink3,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Caps(
              live
                  ? 'Live${current == null ? '' : ' · ${current.name}'}'
                  : 'Reconnecting',
              color: live ? M.accent : M.ink3,
            ),
            const SizedBox(width: 12),
            if (snap.isDemo) const Tag('Demo event'),
          ],
        ),
        SizedBox(height: 18 * scale),
        Text(
          snap.eventName,
          style: M.display.copyWith(fontSize: 72 * scale, height: 1.05),
        ),
        SizedBox(height: 40 * scale),
        TweenAnimationBuilder<double>(
          tween: Tween(end: snap.photos.toDouble()),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          builder: (_, v, _) => Text(
            grouped(v.round()),
            style: M
                .number(188 * scale)
                .copyWith(height: 1, letterSpacing: -8 * scale),
          ),
        ),
        SizedBox(height: 8 * scale),
        Text('photos so far', style: M.title.copyWith(fontSize: 28 * scale)),
        SizedBox(height: 20 * scale),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _Chip(
              value: snap.guests,
              label: snap.guests == 1 ? 'guest shooting' : 'guests shooting',
              scale: scale,
            ),
            _Chip(
              value: snap.onPhones,
              label: 'still on phones, sending',
              scale: scale,
            ),
          ],
        ),
        SizedBox(height: 24 * scale),
        Text(
          current == null
              ? 'Every album is open.'
              : 'Nobody sees a photo until the album opens, ${revealLabel(current.revealAt)}',
          style: M.body.copyWith(
            fontSize: 20 * scale.clamp(0.8, 1.3),
            color: M.ink3,
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.value, required this.label, required this.scale});
  final int value;
  final String label;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final size = 20 * scale.clamp(0.8, 1.3);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18 * scale,
        vertical: 12 * scale,
      ),
      decoration: BoxDecoration(
        color: M.surface,
        borderRadius: BorderRadius.circular(M.rCard),
      ),
      child: Text.rich(
        TextSpan(
          style: M.body.copyWith(fontSize: size, color: M.ink2),
          children: [
            TextSpan(text: grouped(value), style: M.number(size)),
            TextSpan(text: ' $label'),
          ],
        ),
      ),
    );
  }
}

class _Side extends StatelessWidget {
  const _Side({required this.snap, required this.code, required this.now});
  final WallSnapshot snap;
  final String code;
  final DateTime now;

  static String _ago(Duration d) {
    if (d.inSeconds < 45) return 'now';
    if (d.inMinutes < 60) return '${d.inMinutes}m';
    return '${d.inHours}h';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: M.line),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Caps('Just now'),
              const SizedBox(height: 6),
              if (snap.activity.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    'Waiting for the first guest to scan',
                    style: M.subhead,
                  ),
                ),
              for (final (i, a) in snap.activity.indexed)
                InfoRow(
                  leading: Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: M.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      a.name.characters.first.toUpperCase(),
                      style: M.headline,
                    ),
                  ),
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: a.name),
                        TextSpan(
                          text: a.kind == 'joined'
                              ? ' joined'
                              : ' sent ${plural(a.count, 'photo')}',
                          style: M.body,
                        ),
                      ],
                    ),
                  ),
                  trailing: Text(
                    _ago(now.difference(a.at)),
                    style: M.number(14, color: M.ink3),
                  ),
                  divider: i < snap.activity.length - 1,
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: M.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: M.bg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: QrImageView(
                  data: joinLink(code).toString(),
                  size: 96,
                  padding: EdgeInsets.zero,
                  eyeStyle: const QrEyeStyle(
                    color: M.ink,
                    eyeShape: QrEyeShape.square,
                  ),
                  dataModuleStyle: const QrDataModuleStyle(
                    color: M.ink,
                    dataModuleShape: QrDataModuleShape.square,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scan to shoot',
                      style: M.title.copyWith(fontSize: 20),
                    ),
                    Text('No app. Works with no signal.', style: M.subhead),
                    const SizedBox(height: 4),
                    Text(code, style: M.number(22).copyWith(letterSpacing: 1)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
