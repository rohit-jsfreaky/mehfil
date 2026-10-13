// Adds demo guests who take real photos (test JPEGs) into a roll, the way the
// app does it: each photo's row goes through offline sync (the guest's
// personal space) and its file through the upload endpoint. For local testing
// and the judges' demo event only.
//
//   dart run mehfil_tools:seed_guests --code D8JK8J --roll 34 --guest Bua:3 --guest Rahul:2
import 'dart:io';

import 'package:args/args.dart';
import 'package:mehfil_tools/mehfil_tools.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';

Future<void> main(List<String> argv) async {
  final args =
      (ArgParser()
            ..addOption('server', defaultsTo: 'http://localhost:8080/')
            ..addOption('code', mandatory: true)
            ..addOption('roll', mandatory: true)
            ..addMultiOption('guest'))
          .parse(argv);
  final rollId = int.parse(args['roll'] as String);
  final tmp = Directory.systemTemp.createTempSync('mehfil-seed-');
  var n = 0;
  for (final spec in args['guest'] as List<String>) {
    final [name, count] = spec.split(':');
    final client = connect(args['server'] as String);
    final join = await joinAsGuest(client, args['code'] as String, name);
    final local = await client.createSyncSession(
      '${tmp.path}/${join.guest.authUserId.uuid}.db',
      isDebugMode: false,
      persistentUserId: join.guest.authUserId,
    );
    for (var i = 0; i < int.parse(count); i++) {
      final bytes = testJpeg(n++ * 7 + 3);
      final id = newShotId();
      await Shot.db.insertRow(
        local,
        Shot(
          id: id,
          eventId: join.event.eventId,
          rollId: rollId,
          guestName: name,
          takenAt: DateTime.now().toUtc(),
          sha256: sha256Of(bytes),
          width: 0,
          height: 0,
          sizeBytes: bytes.lengthInBytes,
        ),
      );
      await uploadShot(client, rollId: rollId, bytes: bytes, shotId: id);
    }
    await client.offlineSync.syncOnce(local);
    await local.close();
    stdout.writeln('$name sent $count');
  }
  exit(0);
}
