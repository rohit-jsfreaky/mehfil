// Proof: "The reveal fires even after a server restart, and fires once."
//
//   dart run mehfil_tools:proof_reveal_restart setup  --server URL --log server.log
//   (stop the server, start it again)
//   dart run mehfil_tools:proof_reveal_restart check  --server URL
//
// `setup` creates a demo event whose roll reveals in --delay seconds, joins two
// guests and uploads photos. `check` waits for the reveal time, then reads the
// reveal log and the album through the API, and writes the result to
// evidence/proofs/.
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:mehfil_tools/mehfil_tools.dart';

const stateFile = '.proof_reveal_restart.json';

Future<void> main(List<String> argv) async {
  final parser = ArgParser()
    ..addOption('server', defaultsTo: 'http://localhost:8080/')
    ..addOption('log')
    ..addOption('delay', defaultsTo: '90')
    ..addOption('evidence', defaultsTo: '../../evidence/proofs')
    ..addOption('email', defaultsTo: 'proof-host@mehfil.dev')
    ..addOption('password', defaultsTo: 'proof-host-password-1');
  final args = parser.parse(argv);
  final command = args.rest.firstOrNull;
  final server = args['server'] as String;

  if (command == 'setup') {
    final host = connect(server);
    await signInHost(
      host,
      email: args['email'] as String,
      password: args['password'] as String,
      serverLog: args['log'] as String?,
    );
    final serverNow = await host.guest.now();
    final revealAt = serverNow.add(Duration(seconds: int.parse(args['delay'])));
    final event = await host.events.createEvent(
      'Proof (demo): reveal survives a restart',
      [RollDraft(name: 'Proof roll', revealAt: revealAt)],
      isDemo: true,
    );
    final rollId = event.rolls.single.id!;
    final code = event.event.joinCode;

    var photos = 0;
    for (final (i, name) in ['Bua', 'Chachu'].indexed) {
      final guest = connect(server);
      await joinAsGuest(guest, code, name);
      for (var n = 0; n < 2; n++) {
        await uploadShot(guest, rollId: rollId, bytes: testJpeg(i * 10 + n));
        photos++;
      }
    }

    File(stateFile).writeAsStringSync(
      jsonEncode({
        'eventId': event.event.id,
        'rollId': rollId,
        'joinCode': code,
        'revealAt': revealAt.toIso8601String(),
        'photosUploaded': photos,
        'setupAt': DateTime.now().toUtc().toIso8601String(),
      }),
    );
    stdout.writeln(
      'SETUP event=${event.event.id} roll=$rollId code=$code '
      'revealAt=${revealAt.toIso8601String()} photos=$photos',
    );
    stdout.writeln(
      'Now restart the server before ${revealAt.toIso8601String()}.',
    );
    return;
  }

  if (command == 'check') {
    final state =
        jsonDecode(File(stateFile).readAsStringSync()) as Map<String, dynamic>;
    final revealAt = DateTime.parse(state['revealAt'] as String);
    final host = connect(server);
    await signInHost(
      host,
      email: args['email'] as String,
      password: args['password'] as String,
    );

    // Future calls are picked up on the server's scan interval (5 s default).
    final deadline = revealAt.add(const Duration(seconds: 60));
    List<RevealLog> reveals = [];
    WallSnapshot wall;
    while (true) {
      wall = await host.wall.snapshot(state['joinCode'] as String);
      reveals = await host.events.reveals(state['eventId'] as int);
      if (reveals.isNotEmpty || wall.serverNow.isAfter(deadline)) break;
      await Future<void>.delayed(const Duration(seconds: 3));
    }
    // Wait a little longer to catch a second (wrong) reveal.
    await Future<void>.delayed(const Duration(seconds: 12));
    reveals = await host.events.reveals(state['eventId'] as int);
    wall = await host.wall.snapshot(state['joinCode'] as String);

    final roll = wall.rolls.single;
    final pass =
        reveals.length == 1 &&
        reveals.single.trigger == 'schedule' &&
        roll.revealedAt != null &&
        !roll.revealedAt!.isBefore(revealAt) &&
        reveals.single.photos == state['photosUploaded'];
    final result = {
      'claim': 'The reveal fires even after a server restart, and fires once.',
      'pass': pass,
      ...state,
      'revealLog': [
        for (final r in reveals)
          {
            'trigger': r.trigger,
            'photos': r.photos,
            'revealedAt': r.revealedAt.toIso8601String(),
          },
      ],
      'rollRevealedAt': roll.revealedAt?.toIso8601String(),
      'lateBySeconds':
          roll.revealedAt?.difference(revealAt).inMilliseconds == null
          ? null
          : roll.revealedAt!.difference(revealAt).inMilliseconds / 1000,
      'checkedAtServer': wall.serverNow.toIso8601String(),
    };
    final dir = Directory(args['evidence'] as String)
      ..createSync(recursive: true);
    final out = File(
      '${dir.path}/reveal-restart-${DateTime.now().toUtc().millisecondsSinceEpoch}.json',
    );
    out.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(result));
    stdout.writeln(
      '${pass ? 'PASS' : 'FAIL'} reveal survives restart: '
      '${reveals.length} reveal(s), trigger=${reveals.firstOrNull?.trigger}, '
      'late by ${result['lateBySeconds']} s → ${out.path}',
    );
    exitCode = pass ? 0 : 1;
    return;
  }

  stderr.writeln(
    'usage: proof_reveal_restart setup|check [options]\n${parser.usage}',
  );
  exitCode = 64;
}
