// Creates a demo event (labelled "demo") as the given host and prints its
// join code. Used for local testing and for the judges' demo event.
//
//   dart run mehfil_tools:demo_event --name "Riya & Arjun (demo)" --reveal-minutes 600
import 'dart:io';

import 'package:args/args.dart';
import 'package:mehfil_tools/mehfil_tools.dart';

Future<void> main(List<String> argv) async {
  final args =
      (ArgParser()
            ..addOption('server', defaultsTo: 'http://localhost:8080/')
            ..addOption('log')
            ..addOption('email', defaultsTo: 'proof-host@mehfil.dev')
            ..addOption('password', defaultsTo: 'proof-host-password-1')
            ..addOption('name', defaultsTo: 'Riya & Arjun (demo)')
            ..addMultiOption('roll', defaultsTo: ['Sangeet'])
            ..addOption('reveal-minutes', defaultsTo: '720')
            ..addOption('first-reveal-minutes')
            ..addOption('hosted-by', defaultsTo: 'the Sharma family'))
          .parse(argv);

  final host = connect(args['server'] as String);
  await signInHost(
    host,
    email: args['email'] as String,
    password: args['password'] as String,
    serverLog: args['log'] as String?,
  );
  final now = await host.guest.now();
  final minutes = int.parse(args['reveal-minutes'] as String);
  final event = await host.events.createEvent(
    args['name'] as String,
    [
      for (final (i, name) in (args['roll'] as List<String>).indexed)
        RollDraft(
          name: name,
          revealAt: now.add(
            Duration(
              minutes: i == 0 && args['first-reveal-minutes'] != null
                  ? int.parse(args['first-reveal-minutes'] as String)
                  : minutes + i * 60,
            ),
          ),
        ),
    ],
    isDemo: true,
    hostedBy: args['hosted-by'] as String,
  );
  stdout.writeln('EVENT ${event.event.id} CODE ${event.event.joinCode}');
  for (final r in event.rolls) {
    stdout.writeln(
      'ROLL ${r.id} ${r.name} reveals ${r.revealAt.toIso8601String()}',
    );
  }
  exit(0);
}
