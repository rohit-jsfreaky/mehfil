// Writes what the server really holds for an event (synced rows, received
// files, both) to evidence/. Every published delivery number comes from here.
//
//   dart run mehfil_tools:delivery_report --event 34 --label offline-browser-test
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:mehfil_tools/mehfil_tools.dart';

Future<void> main(List<String> argv) async {
  final args =
      (ArgParser()
            ..addOption('server', defaultsTo: 'http://localhost:8080/')
            ..addOption('email', defaultsTo: 'proof-host@mehfil.dev')
            ..addOption('password', defaultsTo: 'proof-host-password-1')
            ..addOption('event', mandatory: true)
            ..addOption('label', defaultsTo: 'delivery')
            ..addOption('note', defaultsTo: '')
            ..addOption('evidence', defaultsTo: '../../evidence/proofs'))
          .parse(argv);

  final host = connect(args['server'] as String);
  await signInHost(
    host,
    email: args['email'] as String,
    password: args['password'] as String,
  );
  final r = await host.events.delivery(int.parse(args['event'] as String));
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
