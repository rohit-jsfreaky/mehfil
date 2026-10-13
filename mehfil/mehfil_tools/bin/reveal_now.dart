// Opens a roll now, as the host would with "Reveal now".
//
//   dart run mehfil_tools:reveal_now --roll 34
import 'dart:io';

import 'package:args/args.dart';
import 'package:mehfil_tools/mehfil_tools.dart';

Future<void> main(List<String> argv) async {
  final args =
      (ArgParser()
            ..addOption('server', defaultsTo: 'http://localhost:8080/')
            ..addOption('email', defaultsTo: 'proof-host@mehfil.dev')
            ..addOption('password', defaultsTo: 'proof-host-password-1')
            ..addOption('roll', mandatory: true))
          .parse(argv);
  final host = connect(args['server'] as String);
  await signInHost(
    host,
    email: args['email'] as String,
    password: args['password'] as String,
  );
  final roll = await host.events.revealNow(int.parse(args['roll'] as String));
  stdout.writeln(
    'REVEALED roll ${roll.id} ${roll.name} at ${roll.revealedAt?.toIso8601String()}',
  );
  exit(0);
}
