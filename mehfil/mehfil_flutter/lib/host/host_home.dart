import 'package:flutter/material.dart';
import 'package:mehfil_client/mehfil_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../ui/format.dart';
import '../ui/icons.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';
import 'create_event_screen.dart';
import 'host_event_screen.dart';
import 'host_sign_in.dart';

/// The host's side: sign in, or the list of their events.
class HostHome extends StatefulWidget {
  const HostHome({super.key});

  @override
  State<HostHome> createState() => _HostHomeState();
}

class _HostHomeState extends State<HostHome> {
  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_changed);
    hostMode.addListener(_changed);
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_changed);
    hostMode.removeListener(_changed);
    super.dispose();
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isHost = client.auth.isAuthenticated && hostMode.value;
    return isHost ? const _Events() : const HostSignIn();
  }
}

class _Events extends StatefulWidget {
  const _Events();

  @override
  State<_Events> createState() => _EventsState();
}

class _EventsState extends State<_Events> {
  late Future<List<HostEvent>> _events = client.events.myEvents();

  void _reload() => setState(() => _events = client.events.myEvents());

  Future<void> _open(HostEvent e) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => HostEventScreen(initial: e)),
    );
    _reload();
  }

  Future<void> _create() async {
    final created = await Navigator.of(context).push<HostEvent>(
      MaterialPageRoute(builder: (_) => const CreateEventScreen()),
    );
    _reload();
    if (created != null && mounted) await _open(created);
  }

  @override
  Widget build(BuildContext context) {
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
                IconBtn(
                  icon: Ph.signOut,
                  label: 'Sign out',
                  onTap: () async {
                    await client.auth.signOutDevice();
                    await setHostMode(false);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('Your events', style: M.largeTitle),
          const SizedBox(height: 4),
          Text(
            'Each event gets one QR. Guests shoot, you choose when the album opens.',
            style: M.subhead,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<HostEvent>>(
              future: _events,
              builder: (context, snap) {
                if (snap.hasError) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Note(friendlyError(snap.error!)),
                  );
                }
                if (!snap.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: M.ink,
                      strokeWidth: 2,
                    ),
                  );
                }
                final events = snap.data!;
                if (events.isEmpty) {
                  return const Align(
                    alignment: Alignment.topCenter,
                    child: StatusCard(
                      icon: Ph.calendarBlank,
                      title: 'No events yet',
                      subtitle:
                          'Make one for the next function: Haldi, Sangeet, Shaadi, or a dinner with friends.',
                    ),
                  );
                }
                return ListView(
                  children: [
                    for (final e in events)
                      InfoRow(
                        leading: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: M.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            e.event.name.characters.first.toUpperCase(),
                            style: M.headline.copyWith(
                              fontFamily: M.serif,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            Flexible(
                              child: Text(
                                e.event.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (e.event.isDemo) ...[
                              const SizedBox(width: 8),
                              const Tag('Demo'),
                            ],
                          ],
                        ),
                        subtitle:
                            '${e.rolls.map((r) => r.name).join(' · ')} · ${plural(e.guests, 'guest')}',
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(grouped(e.photos), style: M.number(17)),
                            Text(
                              'photos',
                              style: M.footnote.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                        onTap: () => _open(e),
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Button(label: 'New event', icon: Ph.plus, onTap: _create),
        ],
      ),
    );
  }
}
