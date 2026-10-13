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
import 'event.dart' as _iu57571s;
import 'roll.dart' as _iizodh34;

abstract class HostEvent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  HostEvent._({
    required this.event,
    required this.rolls,
    required this.photos,
    required this.guests,
  });

  factory HostEvent({
    required _iu57571s.Event event,
    required List<_iizodh34.Roll> rolls,
    required int photos,
    required int guests,
  }) = _HostEventImpl;

  factory HostEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return HostEvent(
      event: _i5qynj39.Protocol().deserialize<_iu57571s.Event>(
        jsonSerialization['event'],
      ),
      rolls: _i5qynj39.Protocol().deserialize<List<_iizodh34.Roll>>(
        jsonSerialization['rolls'],
      ),
      photos: jsonSerialization['photos'] as int,
      guests: jsonSerialization['guests'] as int,
    );
  }

  _iu57571s.Event event;

  List<_iizodh34.Roll> rolls;

  int photos;

  int guests;

  /// Returns a shallow copy of this [HostEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  HostEvent copyWith({
    _iu57571s.Event? event,
    List<_iizodh34.Roll>? rolls,
    int? photos,
    int? guests,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'HostEvent',
      'event': event.toJson(),
      'rolls': rolls.toJson(valueToJson: (v) => v.toJson()),
      'photos': photos,
      'guests': guests,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'HostEvent',
      'event': event.toJsonForProtocol(),
      'rolls': rolls.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'photos': photos,
      'guests': guests,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _HostEventImpl extends HostEvent {
  _HostEventImpl({
    required _iu57571s.Event event,
    required List<_iizodh34.Roll> rolls,
    required int photos,
    required int guests,
  }) : super._(
         event: event,
         rolls: rolls,
         photos: photos,
         guests: guests,
       );

  /// Returns a shallow copy of this [HostEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  HostEvent copyWith({
    _iu57571s.Event? event,
    List<_iizodh34.Roll>? rolls,
    int? photos,
    int? guests,
  }) {
    return HostEvent(
      event: event ?? this.event.copyWith(),
      rolls: rolls ?? this.rolls.map((e0) => e0.copyWith()).toList(),
      photos: photos ?? this.photos,
      guests: guests ?? this.guests,
    );
  }
}
