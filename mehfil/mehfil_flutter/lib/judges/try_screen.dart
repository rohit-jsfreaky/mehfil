import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mehfil_client/mehfil_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../guest/guest_session.dart';
import '../ui/icons.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';

enum _State { waiting, running, held, broke }

class _Attack {
  _Attack(this.title, this.how, this.run);
  final String title;
  final String how;
  final Future<String> Function() run;
  _State state = _State.waiting;
  String? result;
}

/// "Try to break it": runs real attacks from this browser against the live
/// server, on a demo event, and shows each one being refused.
class TryScreen extends StatefulWidget {
  const TryScreen({super.key, required this.code});
  final String code;

  @override
  State<TryScreen> createState() => _TryScreenState();
}

class _TryScreenState extends State<TryScreen> {
  late final List<_Attack> _attacks = [
    _Attack(
      'Sign in with a made-up QR code',
      'Asks the server for a guest session with the code ZZZZZZ.',
      () async {
        try {
          await client.anonymousIdp.login(token: 'ZZZZZZ');
        } catch (_) {
          return 'Refused: no session without a real QR.';
        }
        throw StateError('A session was created');
      },
    ),
    _Attack(
      "Open another guest's photo before the reveal",
      'Joins as a guest, then asks for a real photo id from a roll that is still hidden.',
      () async {
        final sample = await client.judge.hiddenSample(widget.code);
        if (sample == null) {
          return 'Nothing hidden right now (every roll is open).';
        }
        if (!client.auth.isAuthenticated) {
          await GuestSession.joinEvent(widget.code, 'Judge');
        } else {
          await client.guest.join(widget.code, 'Judge');
        }
        try {
          await client.album.photo(sample.shotId, thumb: false);
        } catch (_) {
          return 'Refused: "This photo is not open yet."';
        }
        throw StateError('The photo came back');
      },
    ),
    _Attack(
      "Guess the photo's storage address",
      "Fetches the file's exact storage path straight from the server's file route.",
      () async {
        final sample = await client.judge.hiddenSample(widget.code);
        if (sample == null) {
          return 'Nothing hidden right now (every roll is open).';
        }
        final url = Uri.parse(client.host).resolve(
          'serverpod_cloud_storage?method=file&path=${Uri.encodeQueryComponent(sample.guessedPath)}',
        );
        final res = await http.get(url);
        final isImage = (res.headers['content-type'] ?? '').contains('image');
        if (res.statusCode == 200 && isImage) {
          throw StateError('The file was served');
        }
        return 'Refused: HTTP ${res.statusCode}. Photos live in private storage.';
      },
    ),
    _Attack(
      'Ask the live wall for photos',
      'Reads the same live stream the TV shows.',
      () async {
        final wall = await client.wall.snapshot(widget.code);
        return 'Counts only: ${wall.photos} photos, ${wall.guests} guests. No image in the stream.';
      },
    ),
  ];

  bool _running = false;

  Future<void> _runAll() async {
    setState(() {
      _running = true;
      for (final a in _attacks) {
        a.state = _State.waiting;
        a.result = null;
      }
    });
    for (final a in _attacks) {
      setState(() => a.state = _State.running);
      try {
        a.result = await a.run();
        a.state = _State.held;
      } catch (e) {
        a.result = e is MehfilException ? e.message : 'Broke: $e';
        a.state = e is MehfilException && e.code == 'not_demo'
            ? _State.waiting
            : _State.broke;
      }
      if (mounted) setState(() {});
    }
    if (mounted) setState(() => _running = false);
  }

  @override
  Widget build(BuildContext context) {
    final held = _attacks.where((a) => a.state == _State.held).length;
    final done = _attacks.every(
      (a) => a.state == _State.held || a.state == _State.broke,
    );
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
                const Tag('For judges'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 24, bottom: 16),
              children: [
                Text('Try to break it', style: M.largeTitle),
                const SizedBox(height: 8),
                Text(
                  'Nobody may see a photo before the reveal. These are real attacks, sent from '
                  'this browser to the live server, on a demo event.',
                  style: M.body.copyWith(color: M.ink2),
                ),
                const SizedBox(height: 20),
                if (done)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: StatusCard(
                      icon: held == _attacks.length
                          ? Ph.checkCircle
                          : Ph.warningCircle,
                      iconColor: held == _attacks.length ? M.ok : M.ink,
                      title: '$held of ${_attacks.length} attacks held',
                    ),
                  ),
                for (final (i, a) in _attacks.indexed)
                  InfoRow(
                    leading: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: M.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: switch (a.state) {
                        _State.running => const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: M.ink,
                          ),
                        ),
                        _State.held => const Icon(Ph.checkCircle, color: M.ok),
                        _State.broke => const Icon(
                          Ph.warningCircle,
                          color: M.ink,
                        ),
                        _State.waiting => Text('${i + 1}', style: M.number(15)),
                      },
                    ),
                    title: Text(a.title),
                    subtitle: a.result ?? a.how,
                    divider: i < _attacks.length - 1,
                  ),
              ],
            ),
          ),
          Button(
            label: done ? 'Run again' : 'Run the attacks',
            busy: _running,
            onTap: _runAll,
          ),
        ],
      ),
    );
  }
}
