import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mehfil_client/mehfil_client.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../client.dart';
import '../ui/format.dart';
import '../ui/icons.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';
import '../wall/wall_screen.dart';
import 'host_album_screen.dart';
import 'print_card_screen.dart';

/// The host's event page: the QR and code to share, live counts, and each
/// function's reveal time (move it, or open it now).
class HostEventScreen extends StatefulWidget {
  const HostEventScreen({super.key, required this.initial});
  final HostEvent initial;

  @override
  State<HostEventScreen> createState() => _HostEventScreenState();
}

class _HostEventScreenState extends State<HostEventScreen> {
  late HostEvent _event = widget.initial;
  StreamSubscription<WallSnapshot>? _wall;
  WallSnapshot? _snap;
  int? _busyRoll;
  String? _error;

  String get code => _event.event.joinCode;
  String get link => joinLink(code).toString();

  @override
  void initState() {
    super.initState();
    _listen();
  }

  void _listen() {
    _wall = client.wall
        .watch(code)
        .listen(
          (s) {
            if (mounted) setState(() => _snap = s);
          },
          onError: (_) => Future<void>.delayed(const Duration(seconds: 3), () {
            if (mounted) _listen();
          }),
          cancelOnError: true,
        );
  }

  @override
  void dispose() {
    unawaited(_wall?.cancel());
    super.dispose();
  }

  Future<void> _refresh() async {
    final all = await client.events.myEvents();
    final me = all.where((e) => e.event.id == _event.event.id).firstOrNull;
    if (me != null && mounted) setState(() => _event = me);
  }

  String get _invite =>
      "You're invited to shoot at ${_event.event.name}! Open this on your phone, no app needed: $link";

  Future<void> _move(Roll roll) async {
    final at = roll.revealAt.toLocal();
    final date = await showDatePicker(
      context: context,
      initialDate: at,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(at),
    );
    if (time == null) return;
    await _run(
      roll,
      () => client.events.setRevealTime(
        roll.id!,
        DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        ).toUtc(),
      ),
    );
  }

  Future<void> _openNow(Roll roll) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Open ${roll.name} now?', style: M.title),
        content: Text(
          'Every guest sees every photo of this function, right away. This cannot be undone.',
          style: M.body.copyWith(color: M.ink2),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: Text('Cancel', style: M.headline),
          ),
          TextButton(
            onPressed: () => Navigator.pop(c, true),
            child: Text('Open now', style: M.headline),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await _run(roll, () => client.events.revealNow(roll.id!));
  }

  Future<void> _run(Roll roll, Future<Object?> Function() action) async {
    setState(() {
      _busyRoll = roll.id;
      _error = null;
    });
    try {
      await action();
      await _refresh();
    } catch (e) {
      setState(() => _error = friendlyError(e));
    } finally {
      if (mounted) setState(() => _busyRoll = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final snap = _snap;
    final counts = {for (final r in snap?.rolls ?? <RollCount>[]) r.rollId: r};
    final anyOpen = _event.rolls.any((r) => r.revealedAt != null);
    return MPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                IconBtn(
                  icon: Ph.caretLeft,
                  label: 'Back',
                  onTap: () => Navigator.of(context).maybePop(),
                ),
                const Spacer(),
                if (anyOpen) ...[
                  Button(
                    label: 'Album',
                    icon: Ph.images,
                    primary: false,
                    small: true,
                    expand: false,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => HostAlbumScreen(event: _event.event),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Button(
                  label: 'Live wall',
                  icon: Ph.television,
                  primary: false,
                  small: true,
                  expand: false,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => WallScreen(code: code),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              children: [
                Text(_event.event.name, style: M.display),
                const SizedBox(height: 4),
                Text(
                  _event.event.isDemo
                      ? 'You are the host · demo event'
                      : 'You are the host',
                  style: M.subhead,
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(M.rCard),
                    border: Border.all(color: M.line),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: M.line),
                        ),
                        child: QrImageView(
                          data: link,
                          size: 100,
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
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Caps('Guest code'),
                            const SizedBox(height: 2),
                            Text(
                              code,
                              style: M.number(26).copyWith(letterSpacing: 1),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Print it on the table cards. Guests scan and shoot, no app.',
                              style: M.footnote,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _ShareTarget(
                      icon: Ph.link,
                      label: 'Copy link',
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: link));
                        if (context.mounted) toast(context, 'Link copied');
                      },
                    ),
                    _ShareTarget(
                      icon: Ph.whatsappLogo,
                      label: 'WhatsApp',
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                            'https://wa.me/?text=${Uri.encodeComponent(_invite)}',
                          ),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                    _ShareTarget(
                      icon: Ph.printer,
                      label: 'Print cards',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) =>
                                PrintCardScreen(event: _event.event),
                          ),
                        );
                      },
                    ),
                    _ShareTarget(
                      icon: Ph.dotsThree,
                      label: 'More',
                      onTap: () {
                        SharePlus.instance.share(
                          ShareParams(
                            text: _invite,
                            subject: _event.event.name,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        value: grouped(snap?.photos ?? _event.photos),
                        label: 'photos in',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: StatTile(
                        value: grouped(snap?.guests ?? _event.guests),
                        label: 'guests',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: StatTile(
                        value: grouped(snap?.onPhones ?? 0),
                        label: 'on phones',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                const Caps('Functions'),
                if (_error != null) ...[
                  const SizedBox(height: 10),
                  Note(_error!),
                ],
                const SizedBox(height: 4),
                for (final (i, roll) in _event.rolls.indexed)
                  _rollRow(
                    roll,
                    counts[roll.id],
                    last: i == _event.rolls.length - 1,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rollRow(Roll roll, RollCount? count, {required bool last}) {
    final photos = count?.photos ?? 0;
    if (roll.revealedAt != null) {
      return InfoRow(
        title: Text(roll.name),
        subtitle:
            'Opened ${revealLabel(roll.revealedAt!)} · ${plural(photos, 'photo')}',
        trailing: Text(
          'Open',
          style: M.footnote.copyWith(color: M.ok, fontWeight: FontWeight.w600),
        ),
        divider: !last,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => HostAlbumScreen(event: _event.event),
          ),
        ),
      );
    }
    // One primary action per screen: only the next function to open gets the
    // buttons; later ones can still have their time changed.
    final next = _event.rolls.where((r) => r.revealedAt == null).firstOrNull;
    if (roll.id != next?.id) {
      return InfoRow(
        title: Text(roll.name),
        subtitle:
            'Opens ${revealLabel(roll.revealAt)} · ${plural(photos, 'photo')} so far',
        trailing: Pill(
          'Change',
          onTap: _busyRoll == null ? () => _move(roll) : null,
        ),
        divider: !last,
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last ? null : const Border(bottom: BorderSide(color: M.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(roll.name, style: M.headline),
          Text(
            'Opens ${revealLabel(roll.revealAt)} · ${plural(photos, 'photo')} so far',
            style: M.footnote,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Button(
                  label: 'Change time',
                  primary: false,
                  small: true,
                  busy: _busyRoll == roll.id,
                  onTap: () => _move(roll),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Button(
                  label: 'Open now',
                  small: true,
                  onTap: _busyRoll == null ? () => _openNow(roll) : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShareTarget extends StatelessWidget {
  const _ShareTarget({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Semantics(
        button: true,
        label: label,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: M.surface,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 21, color: M.ink),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: M.footnote.copyWith(
                  fontSize: 12,
                  color: M.ink,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
