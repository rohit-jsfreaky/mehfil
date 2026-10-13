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
import 'package:mehfil_server/src/generated/protocol.dart' as _i5qynj39;
import 'package:serverpod/serverpod.dart' as _is;
import 'roll.dart' as _iizodh34;

/// What a guest's phone gets when it opens the QR link: no photos, ever.
abstract class EventPublic
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EventPublic._({
    required this.eventId,
    required this.name,
    this.hostedBy,
    required this.guests,
    required this.guestNames,
    required this.joinCode,
    required this.isDemo,
    required this.rolls,
    required this.serverNow,
  });

  factory EventPublic({
    required int eventId,
    required String name,
    String? hostedBy,
    required int guests,
    required List<String> guestNames,
    required String joinCode,
    required bool isDemo,
    required List<_iizodh34.Roll> rolls,
    required DateTime serverNow,
  }) = _EventPublicImpl;

  factory EventPublic.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventPublic(
      eventId: jsonSerialization['eventId'] as int,
      name: jsonSerialization['name'] as String,
      hostedBy: jsonSerialization['hostedBy'] as String?,
      guests: jsonSerialization['guests'] as int,
      guestNames: _i5qynj39.Protocol().deserialize<List<String>>(
        jsonSerialization['guestNames'],
      ),
      joinCode: jsonSerialization['joinCode'] as String,
      isDemo: _is.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
      rolls: _i5qynj39.Protocol().deserialize<List<_iizodh34.Roll>>(
        jsonSerialization['rolls'],
      ),
      serverNow: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverNow'],
      ),
    );
  }

  int eventId;

  String name;

  String? hostedBy;

  /// How many guests joined, and the first few names (for the avatars).
  int guests;

  List<String> guestNames;

  String joinCode;

  bool isDemo;

  List<_iizodh34.Roll> rolls;

  DateTime serverNow;

  /// Returns a shallow copy of this [EventPublic]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EventPublic copyWith({
    int? eventId,
    String? name,
    String? hostedBy,
    int? guests,
    List<String>? guestNames,
    String? joinCode,
    bool? isDemo,
    List<_iizodh34.Roll>? rolls,
    DateTime? serverNow,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventPublic',
      'eventId': eventId,
      'name': name,
      if (hostedBy != null) 'hostedBy': hostedBy,
      'guests': guests,
      'guestNames': guestNames.toJson(),
      'joinCode': joinCode,
      'isDemo': isDemo,
      'rolls': rolls.toJson(valueToJson: (v) => v.toJson()),
      'serverNow': serverNow.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventPublic',
      'eventId': eventId,
      'name': name,
      if (hostedBy != null) 'hostedBy': hostedBy,
      'guests': guests,
      'guestNames': guestNames.toJson(),
      'joinCode': joinCode,
      'isDemo': isDemo,
      'rolls': rolls.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'serverNow': serverNow.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventPublicImpl extends EventPublic {
  _EventPublicImpl({
    required int eventId,
    required String name,
    String? hostedBy,
    required int guests,
    required List<String> guestNames,
    required String joinCode,
    required bool isDemo,
    required List<_iizodh34.Roll> rolls,
    required DateTime serverNow,
  }) : super._(
         eventId: eventId,
         name: name,
         hostedBy: hostedBy,
         guests: guests,
         guestNames: guestNames,
         joinCode: joinCode,
         isDemo: isDemo,
         rolls: rolls,
         serverNow: serverNow,
       );

  /// Returns a shallow copy of this [EventPublic]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EventPublic copyWith({
    int? eventId,
    String? name,
    Object? hostedBy = _Undefined,
    int? guests,
    List<String>? guestNames,
    String? joinCode,
    bool? isDemo,
    List<_iizodh34.Roll>? rolls,
    DateTime? serverNow,
  }) {
    return EventPublic(
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      hostedBy: hostedBy is String? ? hostedBy : this.hostedBy,
      guests: guests ?? this.guests,
      guestNames: guestNames ?? this.guestNames.map((e0) => e0).toList(),
      joinCode: joinCode ?? this.joinCode,
      isDemo: isDemo ?? this.isDemo,
      rolls: rolls ?? this.rolls.map((e0) => e0.copyWith()).toList(),
      serverNow: serverNow ?? this.serverNow,
    );
  }
}
