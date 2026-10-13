import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mehfil_client/mehfil_client.dart';

import '../client.dart';
import '../ui/format.dart';
import '../ui/icons.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';
import 'guest_session.dart';
import 'guest_shell.dart';

/// What a guest sees after scanning the QR: an invitation, not a form.
/// No app, no account, no password: a name and one button.
class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key, required this.code});
  final String code;

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final _name = TextEditingController();
  EventPublic? _event;
  String? _error;
  bool _busy = false;
  bool _loading = true;

  /// No signal: try again every few seconds and carry on by itself, so a
  /// guest who opened the link and then walked into the hall is not stuck.
  Timer? _retry;
  bool _waiting = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _retry?.cancel();
    _name.dispose();
    super.dispose();
  }

  void _retryLater(Future<void> Function() action) {
    _retry?.cancel();
    _retry = Timer(const Duration(seconds: 4), action);
  }

  Future<void> _load() async {
    // Joined before on this phone: straight in, even with no signal.
    final saved = await GuestSession.saved(widget.code);
    if (saved != null) {
      await _enter(saved);
      return;
    }
    try {
      final event = await client.guest.event(widget.code);
      if (mounted) {
        setState(() {
          _event = event;
          _error = null;
          _waiting = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      final noSignal = isNoSignal(e);
      setState(() {
        _waiting = noSignal;
        _error = noSignal ? null : friendlyError(e);
      });
      if (noSignal) _retryLater(_load);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _join() async {
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(
        () => _error = 'Type your name, so the couple knows who took what.',
      );
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await _enter(await GuestSession.joinEvent(widget.code, name));
    } catch (e) {
      if (!mounted) return;
      if (isNoSignal(e)) {
        // Keep the button busy and join the moment the signal is back.
        setState(() {
          _waiting = true;
          _error =
              'No signal yet. Keep this page open: you will be in as soon as '
              'it comes back.';
        });
        _retryLater(_join);
        return;
      }
      setState(() {
        _waiting = false;
        _error = friendlyError(e);
        _busy = false;
      });
    }
  }

  Future<void> _enter(JoinResult join) async {
    final session = await GuestSession.open(join);
    if (!mounted) return;
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => GuestShell(session: session)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = _event;
    if (_loading) {
      return const MPage(
        child: Center(
          child: CircularProgressIndicator(color: M.ink, strokeWidth: 2),
        ),
      );
    }
    if (event == null && _waiting) {
      return MPage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
              child: Align(alignment: Alignment.centerLeft, child: Wordmark()),
            ),
            const SizedBox(height: 28),
            Text('Get signal once to join', style: M.largeTitle),
            const SizedBox(height: 12),
            Text(
              'Mehfil needs signal one time to add you to the event. Step '
              'near the entrance or join the venue Wi-Fi. After that it works '
              'with no signal.',
              style: M.subhead,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: M.ink,
                    strokeWidth: 2,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Waiting for signal. This page carries on by itself.',
                  style: M.footnote.copyWith(color: M.ink3),
                ),
              ],
            ),
          ],
        ),
      );
    }
    if (event == null) {
      return MPage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
              child: Align(alignment: Alignment.centerLeft, child: Wordmark()),
            ),
            const SizedBox(height: 28),
            Text('This link did not open an event', style: M.largeTitle),
            const SizedBox(height: 16),
            Note(_error ?? 'Ask the host for the QR code again.'),
          ],
        ),
      );
    }

    final firstOpen = event.rolls
        .where((r) => r.revealedAt == null)
        .map((r) => r.revealAt)
        .fold<DateTime?>(null, (a, b) => a == null || b.isBefore(a) ? b : a);
    final shots = event.rolls.isEmpty ? 27 : event.rolls.first.shotsPerGuest;

    return MPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                const Wordmark(),
                const Spacer(),
                if (event.isDemo) const Tag('Demo event'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 24, bottom: 16),
              children: [
                const Caps("You're invited to shoot"),
                const SizedBox(height: 6),
                Text(event.name, style: M.display.copyWith(fontSize: 46)),
                if (event.hostedBy != null) ...[
                  const SizedBox(height: 6),
                  Text('Hosted by ${event.hostedBy}', style: M.subhead),
                ],
                const SizedBox(height: 18),
                InfoRow(
                  icon: Ph.filmStrip,
                  title: Text(plural(event.rolls.length, 'function')),
                  subtitle: event.rolls.map((r) => r.name).join(' · '),
                ),
                if (firstOpen != null)
                  InfoRow(
                    icon: Ph.lock,
                    title: Text.rich(
                      TextSpan(
                        text: 'Photos open ',
                        children: [
                          TextSpan(
                            text: revealLabel(firstOpen),
                            style: M.number(15),
                          ),
                        ],
                      ),
                    ),
                    subtitle: 'Nobody sees them before that',
                  ),
                InfoRow(
                  icon: Ph.users,
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: '${event.guests}', style: M.number(16)),
                        TextSpan(
                          text: event.guests == 1
                              ? ' guest shooting'
                              : ' guests shooting',
                        ),
                      ],
                    ),
                  ),
                  subtitle: event.guestNames.isEmpty
                      ? 'Be the first'
                      : '${event.guestNames.take(3).join(', ')}${event.guests > 3 ? ' and others' : ''}',
                  trailing: event.guestNames.isEmpty
                      ? null
                      : Initials(event.guestNames),
                ),
                const SizedBox(height: 24),
                const Caps('How it works'),
                const SizedBox(height: 12),
                _Step(1, 'Shoot up to $shots photos per function'),
                _Step(2, 'No signal? They wait on your phone and send later'),
                _Step(3, 'The album opens for everyone at once'),
              ],
            ),
          ),
          const Caps('Your name'),
          const SizedBox(height: 8),
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            maxLength: 40,
            style: M.body,
            decoration: const InputDecoration(
              hintText: 'So the couple knows who took what',
              counterText: '',
            ),
            onSubmitted: (_) => _join(),
          ),
          if (_error != null) ...[const SizedBox(height: 10), Note(_error!)],
          const SizedBox(height: 12),
          Button(label: 'Start shooting', busy: _busy, onTap: _join),
          const SizedBox(height: 12),
          Text(
            'No app to install · works with no signal',
            textAlign: TextAlign.center,
            style: M.footnote.copyWith(color: M.ink3),
          ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step(this.n, this.text);
  final int n;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: M.ink,
              shape: BoxShape.circle,
            ),
            child: Text('$n', style: M.number(12, color: M.bg)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: M.subhead.copyWith(color: M.ink)),
          ),
        ],
      ),
    );
  }
}
