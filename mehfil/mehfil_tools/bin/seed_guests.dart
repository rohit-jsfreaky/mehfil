// Adds demo guests who take real photos (test JPEGs) into a roll, the way the
// app does it. For local testing and the judges' demo event only.
//
//   dart run mehfil_tools:seed_guests --code D8JK8J --roll 34 --guest Bua:3 --guest Rahul:2
import 'dart:io';

import 'package:args/args.dart';
import 'package:mehfil_tools/mehfil_tools.dart';

Future<void> main(List<String> argv) async {
  final args =
      (ArgParser()
            ..addOption('server', defaultsTo: 'http://localhost:8080/')
            ..addOption('code', mandatory: true)
            ..addOption('roll', mandatory: true)
            ..addMultiOption('guest'))
          .parse(argv);
  final rollId = int.parse(args['roll'] as String);
  var n = 0;
  for (final spec in args['guest'] as List<String>) {
    final [name, count] = spec.split(':');
    final client = connect(args['server'] as String);
    await joinAsGuest(client, args['code'] as String, name);
    for (var i = 0; i < int.parse(count); i++) {
      await uploadShot(client, rollId: rollId, bytes: testJpeg(n++ * 7 + 3));
    }
    stdout.writeln('$name sent $count');
  }
  exit(0);
}
