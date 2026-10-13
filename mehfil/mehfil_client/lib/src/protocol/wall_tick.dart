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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// Posted on the event channel whenever counts may have changed.
abstract class WallTick
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WallTick._({
    required this.eventId,
    required this.reason,
  });

  factory WallTick({
    required int eventId,
    required String reason,
  }) = _WallTickImpl;

  factory WallTick.fromJson(Map<String, dynamic> jsonSerialization) {
    return WallTick(
      eventId: jsonSerialization['eventId'] as int,
      reason: jsonSerialization['reason'] as String,
    );
  }

  int eventId;

  String reason;

  /// Returns a shallow copy of this [WallTick]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WallTick copyWith({
    int? eventId,
    String? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WallTick',
      'eventId': eventId,
      'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WallTick',
      'eventId': eventId,
      'reason': reason,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _WallTickImpl extends WallTick {
  _WallTickImpl({
    required int eventId,
    required String reason,
  }) : super._(
         eventId: eventId,
         reason: reason,
       );

  /// Returns a shallow copy of this [WallTick]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WallTick copyWith({
    int? eventId,
    String? reason,
  }) {
    return WallTick(
      eventId: eventId ?? this.eventId,
      reason: reason ?? this.reason,
    );
  }
}
