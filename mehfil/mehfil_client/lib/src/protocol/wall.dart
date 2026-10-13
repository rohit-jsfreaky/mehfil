/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mehfil_client/src/protocol/protocol.dart' as _iyjh1ba9;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'roll_count.dart' as _i33oi965;
import 'wall_activity.dart' as _i0jjlicg;

/// Live counts for the couple's screen. Counts only: no photo leaves the
/// server before the reveal.
abstract class WallSnapshot
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WallSnapshot._({
    required this.eventId,
    required this.eventName,
    required this.isDemo,
    required this.photos,
    required this.guests,
    required this.onPhones,
    required this.rolls,
    required this.activity,
    required this.serverNow,
  });

  factory WallSnapshot({
    required int eventId,
    required String eventName,
    required bool isDemo,
    required int photos,
    required int guests,
    required int onPhones,
    required List<_i33oi965.RollCount> rolls,
    required List<_i0jjlicg.WallActivity> activity,
    required DateTime serverNow,
  }) = _WallSnapshotImpl;

  factory WallSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return WallSnapshot(
      eventId: jsonSerialization['eventId'] as int,
      eventName: jsonSerialization['eventName'] as String,
      isDemo: _isc.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
      photos: jsonSerialization['photos'] as int,
      guests: jsonSerialization['guests'] as int,
      onPhones: jsonSerialization['onPhones'] as int,
      rolls: _iyjh1ba9.Protocol().deserialize<List<_i33oi965.RollCount>>(
        jsonSerialization['rolls'],
      ),
      activity: _iyjh1ba9.Protocol().deserialize<List<_i0jjlicg.WallActivity>>(
        jsonSerialization['activity'],
      ),
      serverNow: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverNow'],
      ),
    );
  }

  int eventId;

  String eventName;

  bool isDemo;

  int photos;

  int guests;

  /// Shots whose rows synced but whose files have not arrived yet.
  int onPhones;

  List<_i33oi965.RollCount> rolls;

  /// Latest happenings, newest first.
  List<_i0jjlicg.WallActivity> activity;

  DateTime serverNow;

  /// Returns a shallow copy of this [WallSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WallSnapshot copyWith({
    int? eventId,
    String? eventName,
    bool? isDemo,
    int? photos,
    int? guests,
    int? onPhones,
    List<_i33oi965.RollCount>? rolls,
    List<_i0jjlicg.WallActivity>? activity,
    DateTime? serverNow,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WallSnapshot',
      'eventId': eventId,
      'eventName': eventName,
      'isDemo': isDemo,
      'photos': photos,
      'guests': guests,
      'onPhones': onPhones,
      'rolls': rolls.toJson(valueToJson: (v) => v.toJson()),
      'activity': activity.toJson(valueToJson: (v) => v.toJson()),
      'serverNow': serverNow.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WallSnapshot',
      'eventId': eventId,
      'eventName': eventName,
      'isDemo': isDemo,
      'photos': photos,
      'guests': guests,
      'onPhones': onPhones,
      'rolls': rolls.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'activity': activity.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'serverNow': serverNow.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _WallSnapshotImpl extends WallSnapshot {
  _WallSnapshotImpl({
    required int eventId,
    required String eventName,
    required bool isDemo,
    required int photos,
    required int guests,
    required int onPhones,
    required List<_i33oi965.RollCount> rolls,
    required List<_i0jjlicg.WallActivity> activity,
    required DateTime serverNow,
  }) : super._(
         eventId: eventId,
         eventName: eventName,
         isDemo: isDemo,
         photos: photos,
         guests: guests,
         onPhones: onPhones,
         rolls: rolls,
         activity: activity,
         serverNow: serverNow,
       );

  /// Returns a shallow copy of this [WallSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WallSnapshot copyWith({
    int? eventId,
    String? eventName,
    bool? isDemo,
    int? photos,
    int? guests,
    int? onPhones,
    List<_i33oi965.RollCount>? rolls,
    List<_i0jjlicg.WallActivity>? activity,
    DateTime? serverNow,
  }) {
    return WallSnapshot(
      eventId: eventId ?? this.eventId,
      eventName: eventName ?? this.eventName,
      isDemo: isDemo ?? this.isDemo,
      photos: photos ?? this.photos,
      guests: guests ?? this.guests,
      onPhones: onPhones ?? this.onPhones,
      rolls: rolls ?? this.rolls.map((e0) => e0.copyWith()).toList(),
      activity: activity ?? this.activity.map((e0) => e0.copyWith()).toList(),
      serverNow: serverNow ?? this.serverNow,
    );
  }
}
