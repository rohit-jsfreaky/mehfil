// Proof: "Where future calls are switched off (Serverpod Cloud's free Starter
// plan), the reveal clock still opens the album, once, with no client timer."
//
//   dart run mehfil_tools:proof_reveal_clock --server URL --email E --password P
//
// With --restart-note, the server is restarted by hand while this waits
// (serverpod cloud deploy --redeploy); polling keeps going through the
// restart, and the note is saved with the result. --photos DIR uploads the
// .jpg files in DIR instead of generated test images.
//
// Creates a demo event whose roll reveals in --delay seconds, joins two guests,
// uploads photos, then only watches: nobody presses "Reveal now". Writes the
// result to evidence/proofs/.
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:args/args.dart';
import 'package:mehfil_tools/mehfil_tools.dart';

Future<void> main(List<String> argv) async {
  final args =
      (ArgParser()
            ..addOption('server', defaultsTo: 'http://localhost:8080/')
            ..addOption('log')
            ..addOption('delay', defaultsTo: '60')
            ..addOption('evidence', defaultsTo: '../../evidence/proofs')
            ..addOption('name', defaultsTo: 'Proof (demo): reveal clock')
            ..addOption('photos')
            ..addOption('restart-note')
            ..addOption('email', defaultsTo: 'proof-host@mehfil.dev')
            ..addOption('password', defaultsTo: 'proof-host-password-1'))
          .parse(argv);
  final server = args['server'] as String;

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
    args['name'] as String,
    [RollDraft(name: 'Proof roll', revealAt: revealAt)],
    isDemo: true,
    hostedBy: null,
  );
  final rollId = event.rolls.single.id!;
  final code = event.event.joinCode;

  final real = args['photos'] == null
      ? <File>[]
      : (Directory(args['photos'] as String)
            .listSync()
            .whereType<File>()
            .where((f) => f.path.toLowerCase().endsWith('.jpg'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path)));
  var photos = 0;
  for (final (i, name) in ['Bua', 'Chachu'].indexed) {
    final guest = connect(server);
    await joinAsGuest(guest, code, name);
    for (var n = 0; n < 2; n++) {
      final k = i * 2 + n;
      final bytes = k < real.length
          ? ByteData.sublistView(real[k].readAsBytesSync())
          : testJpeg(i * 10 + n);
      await uploadShot(guest, rollId: rollId, bytes: bytes);
      photos++;
    }
  }
  final uploadsDoneAt = await host.guest.now();
  if (!uploadsDoneAt.isBefore(revealAt)) {
    stderr.writeln('Uploads ran past the reveal time; use a longer --delay.');
    exit(2);
  }
  stdout.writeln(
    'SETUP event=${event.event.id} roll=$rollId code=$code '
    'revealAt=${revealAt.toIso8601String()} photos=$photos — now only watching',
  );

  // Where future calls are off, the clock checks every 5 s with no grace;
  // elsewhere the future call fires first (clock grace: 45 s).
  final deadline = revealAt.add(const Duration(seconds: 120));
  List<RevealLog> reveals = [];
  WallSnapshot wall;
  var unreachable = 0;
  while (true) {
    try {
      wall = await host.wall.snapshot(code);
      reveals = await host.events.reveals(event.event.id!);
    } catch (e) {
      // The server is restarting: keep watching.
      unreachable++;
      stdout.writeln('server not answering (${e.runtimeType}), retrying');
      await Future<void>.delayed(const Duration(seconds: 3));
      continue;
    }
    if (reveals.isNotEmpty || wall.serverNow.isAfter(deadline)) break;
    await Future<void>.delayed(const Duration(seconds: 3));
  }
  // Wait a little longer to catch a second (wrong) reveal.
  await Future<void>.delayed(const Duration(seconds: 15));
  reveals = await host.events.reveals(event.event.id!);
  wall = await host.wall.snapshot(code);

  final album = await host.events.album(event.event.id!);
  final roll = wall.rolls.single;
  final pass =
      reveals.length == 1 &&
      (reveals.single.trigger == 'clock' ||
          reveals.single.trigger == 'schedule') &&
      roll.revealedAt != null &&
      !roll.revealedAt!.isBefore(revealAt) &&
      reveals.single.photos == photos &&
      album.length == photos;
  final result = {
    'claim':
        'With no client timer and no "Reveal now", the server opens the roll '
        'after its reveal time, once.',
    'pass': pass,
    'server': server,
    'eventId': event.event.id,
    'rollId': rollId,
    'revealAt': revealAt.toIso8601String(),
    'photosUploaded': photos,
    'uploadsDoneAt': uploadsDoneAt.toIso8601String(),
    'albumPhotos': album.length,
    'revealLog': [
      for (final r in reveals)
        {
          'trigger': r.trigger,
          'photos': r.photos,
          'revealedAt': r.revealedAt.toIso8601String(),
        },
    ],
    'secondsAfterRevealTime': roll.revealedAt?.difference(revealAt).inSeconds,
    'checkedAt': wall.serverNow.toIso8601String(),
    if (args['restart-note'] != null) 'restart': args['restart-note'],
    'pollsWhileServerUnreachable': unreachable,
    'photoSource': real.isEmpty
        ? 'generated test images'
        : 'frames from two phone clips',
  };

  final dir = Directory(args['evidence'] as String)
    ..createSync(recursive: true);
  final out = File(
    '${dir.path}/reveal-clock-${DateTime.now().millisecondsSinceEpoch}.json',
  );
  out.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(result));
  stdout.writeln(
    '${pass ? 'PASS' : 'FAIL'}  ${reveals.length} reveal(s), trigger '
    '${reveals.map((r) => r.trigger).join(',')}, '
    '${roll.revealedAt?.difference(revealAt).inSeconds} s after the reveal '
    'time → ${out.path}',
  );
  exit(pass ? 0 : 1);
}
