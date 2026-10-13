import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mehfil_client/mehfil_client.dart';

import '../ui/format.dart';
import '../ui/icons.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';
import 'guest_session.dart';

/// The guest's home between shots: what is still on the phone, every
/// function and when it opens, and the live counts.
class EventTab extends StatefulWidget {
  const EventTab({
    super.key,
    required this.session,
    required this.onOpenCamera,
    required this.onOpenAlbum,
  });

  final GuestSession session;
  final VoidCallback onOpenCamera;
  final VoidCallback onOpenAlbum;

  @override
  State<EventTab> createState() => _EventTabState();
}

class _EventTabState extends State<EventTab> {
  late final Timer _clock;
  GuestSession get s => widget.session;

  @override
  void initState() {
    super.initState();
    s.addListener(_changed);
    _clock = Timer.periodic(const Duration(seconds: 1), (_) => _changed());
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _clock.cancel();
    s.removeListener(_changed);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = s.rolls.where((r) => r.revealedAt == null).firstOrNull;
    final counts = {
      for (final r in s.wall?.rolls ?? <RollCount>[]) r.rollId: r,
    };
    return SafeArea(
      bottom: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(M.margin, 12, M.margin, 120),
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Caps(s.event.isDemo ? 'Demo event' : 'Event'),
                    const Spacer(),
                    if (!s.online) const Tag('No signal'),
                  ],
                ),
              ),
              Text(s.event.name, style: M.display),
              const SizedBox(height: 4),
              Text("You're shooting as ${s.guest.name}", style: M.subhead),
              const SizedBox(height: 18),
              _status(),
              const SizedBox(height: 24),
              const Caps('Functions'),
              const SizedBox(height: 10),
              for (final roll in s.rolls) ...[
                _rollCard(roll, current, counts[roll.id]),
                const SizedBox(height: 10),
              ],
              if (current != null) ...[
                const SizedBox(height: 14),
                Caps('${current.name} so far'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        value: grouped(counts[current.id]?.photos ?? 0),
                        label: 'photos',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: StatTile(
                        value: grouped(s.wall?.guests ?? s.event.guests),
                        label: 'guests',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: StatTile(
                        value: _hours(current.revealAt.difference(s.serverNow)),
                        label: 'to the reveal',
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static String _hours(Duration d) {
    if (d.isNegative) return '00:00';
    String two(int n) => n.toString().padLeft(2, '0');
    if (d.inHours >= 100) return '${d.inDays}d';
    return '${two(d.inHours)}:${two(d.inMinutes % 60)}';
  }

  Widget _status() {
    final total = s.waiting + s.sentThisBatch;
    if (s.waiting > 0 && s.online) {
      return StatusCard(
        icon: Ph.cloudArrowUp,
        title:
            'Sending ${s.sentThisBatch + 1} of $total ${total == 1 ? 'photo' : 'photos'}',
        subtitle: 'Safe on this phone until the server has it',
        progress: total == 0 ? 0 : s.sentThisBatch / total,
      );
    }
    if (s.waiting > 0) {
      return StatusCard(
        icon: Ph.wifiSlash,
        title: '${plural(s.waiting, 'photo')} on this phone',
        subtitle: 'Taken with no signal. They send when signal returns.',
      );
    }
    if (s.delivered > 0) {
      return StatusCard(
        icon: Ph.checkCircle,
        iconColor: M.ok,
        title: 'All ${plural(s.delivered, 'photo')} sent',
        subtitle: 'Nothing left on your phone',
      );
    }
    return const StatusCard(
      icon: Ph.camera,
      title: 'Your photos will show up here',
      subtitle: 'Open the camera and start shooting',
    );
  }

  Widget _rollCard(Roll roll, Roll? current, RollCount? count) {
    final open = roll.revealedAt != null;
    final isCurrent = roll.id == current?.id;
    final mine = s.shotsByRoll[roll.id] ?? 0;

    if (isCurrent) {
      return Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(M.rCard),
          border: Border.all(color: M.ink, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(roll.name, style: M.headline)),
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: M.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Shooting now',
                  style: M.footnote.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: M.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'You took $mine of ${roll.shotsPerGuest} · opens ${revealLabel(roll.revealAt)}',
                    style: M.footnote,
                  ),
                ),
                const SizedBox(width: 10),
                Button(
                  label: 'Open camera',
                  small: true,
                  expand: false,
                  onTap: widget.onOpenCamera,
                ),
              ],
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: open ? widget.onOpenAlbum : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(M.rCard),
          border: Border.all(color: M.line),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(roll.name, style: M.headline),
                  Text(
                    open
                        ? 'Album open · ${plural(count?.photos ?? 0, 'photo')}'
                        : 'Opens ${revealLabel(roll.revealAt)}${mine > 0 ? ' · you took $mine' : ''}',
                    style: M.footnote,
                  ),
                ],
              ),
            ),
            Icon(open ? Ph.caretRight : Ph.lock, size: 18, color: M.ink3),
          ],
        ),
      ),
    );
  }
}
