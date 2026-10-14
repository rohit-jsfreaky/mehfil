// Writes what the server really holds for an event (synced rows, received
// files, both) to evidence/. Every published delivery number comes from here.
//
//   dart run mehfil_tools:delivery_report --event 34 --label offline-browser-test
//
// Against the live server, with a real host's own account (the password is
// asked for on screen, so it never lands in a file or the shell history):
//
//   dart run mehfil_tools:delivery_report --server https://mehfil.api.serverpod.space/ //     --email you@example.com --code ABC123 --label phone-test
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:mehfil_tools/mehfil_tools.dart';

Future<void> main(List<String> argv) async {
  final args =
      (ArgParser()
            ..addOption('server', defaultsTo: 'http://localhost:8080/')
            ..addOption('email', defaultsTo: 'proof-host@mehfil.dev')
            ..addOption('password')
            ..addOption('event', help: 'The event id.')
            ..addOption('code', help: 'Or the 6-letter join code.')
            ..addOption('label', defaultsTo: 'delivery')
            ..addOption('note', defaultsTo: '')
            ..addOption('evidence', defaultsTo: '../../evidence/proofs'))
          .parse(argv);

  final email = args['email'] as String;
  final host = connect(args['server'] as String);
  await signInHost(host, email: email, password: _password(args, email));
  final r = await host.events.delivery(await _eventId(host, args));
  final result = {
    'label': args['label'],
    'note': args['note'],
    'eventId': r.eventId,
    'rowsSynced': r.rowsSynced,
    'filesReceived': r.filesReceived,
    'delivered': r.delivered,
    'rowsWithoutFile': r.rowsWithoutFile,
    'filesWithoutRow': r.filesWithoutRow,
    'waitedOverMinute': r.waitedOverMinute,
    'waitedOverMinuteNote':
        "server receivedAt minus the phone's own takenAt clock; > 60 s means it waited on the phone",
    'longestWaitSeconds': r.longestWaitSeconds,
    'guests': [
      for (final g in r.guests)
        {
          'name': g.name,
          'rowsSynced': g.rowsSynced,
          'filesReceived': g.filesReceived,
          'delivered': g.delivered,
        },
    ],
    'serverNow': r.serverNow.toIso8601String(),
  };
  final dir = Directory(args['evidence'] as String)
    ..createSync(recursive: true);
  final out = File(
    '${dir.path}/${args['label']}-event${r.eventId}-${r.serverNow.millisecondsSinceEpoch}.json',
  );
  out.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(result));
  stdout.writeln(
    'rows=${r.rowsSynced} files=${r.filesReceived} delivered=${r.delivered} '
    'rowsOnly=${r.rowsWithoutFile} filesOnly=${r.filesWithoutRow} → ${out.path}',
  );
  exit(0);
}

String _password(ArgResults args, String email) {
  final given =
      args['password'] as String? ??
      Platform.environment['MEHFIL_HOST_PASSWORD'];
  if (given != null && given.isNotEmpty) return given;
  if (email == 'proof-host@mehfil.dev') return 'proof-host-password-1';
  stdout.write('Password for $email: ');
  final hide = stdin.hasTerminal;
  if (hide) stdin.echoMode = false;
  try {
    return stdin.readLineSync()?.trim() ?? '';
  } finally {
    if (hide) {
      stdin.echoMode = true;
      stdout.writeln();
    }
  }
}

Future<int> _eventId(Client host, ArgResults args) async {
  final id = args['event'] as String?;
  if (id != null) return int.parse(id);
  final code = (args['code'] as String?)?.trim().toUpperCase();
  if (code == null || code.isEmpty) {
    stderr.writeln('Give --event <id> or --code <join code>.');
    exit(64);
  }
  for (final e in await host.events.myEvents()) {
    if (e.event.joinCode.toUpperCase() == code) return e.event.id!;
  }
  stderr.writeln('No event with code $code on this host account.');
  exit(66);
}
