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
import 'event_public.dart' as _ilhd52bb;
import 'guest.dart' as _ih9iep0x;

abstract class JoinResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JoinResult._({
    required this.event,
    required this.guest,
    required this.albumSpaceId,
    this.recoveryKey,
  });

  factory JoinResult({
    required _ilhd52bb.EventPublic event,
    required _ih9iep0x.Guest guest,
    required _isc.UuidValue albumSpaceId,
    String? recoveryKey,
  }) = _JoinResultImpl;

  factory JoinResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return JoinResult(
      event: _iyjh1ba9.Protocol().deserialize<_ilhd52bb.EventPublic>(
        jsonSerialization['event'],
      ),
      guest: _iyjh1ba9.Protocol().deserialize<_ih9iep0x.Guest>(
        jsonSerialization['guest'],
      ),
      albumSpaceId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['albumSpaceId'],
      ),
      recoveryKey: jsonSerialization['recoveryKey'] as String?,
    );
  }

  _ilhd52bb.EventPublic event;

  _ih9iep0x.Guest guest;

  _isc.UuidValue albumSpaceId;

  /// Sent once, when the guest first joins: the phone stores it with the
  /// join. Null on later joins (the server keeps only its hash).
  String? recoveryKey;

  /// Returns a shallow copy of this [JoinResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JoinResult copyWith({
    _ilhd52bb.EventPublic? event,
    _ih9iep0x.Guest? guest,
    _isc.UuidValue? albumSpaceId,
    String? recoveryKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JoinResult',
      'event': event.toJson(),
      'guest': guest.toJson(),
      'albumSpaceId': albumSpaceId.toJson(),
      if (recoveryKey != null) 'recoveryKey': recoveryKey,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JoinResult',
      'event': event.toJsonForProtocol(),
      'guest': guest.toJsonForProtocol(),
      'albumSpaceId': albumSpaceId.toJson(),
      if (recoveryKey != null) 'recoveryKey': recoveryKey,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JoinResultImpl extends JoinResult {
  _JoinResultImpl({
    required _ilhd52bb.EventPublic event,
    required _ih9iep0x.Guest guest,
    required _isc.UuidValue albumSpaceId,
    String? recoveryKey,
  }) : super._(
         event: event,
         guest: guest,
         albumSpaceId: albumSpaceId,
         recoveryKey: recoveryKey,
       );

  /// Returns a shallow copy of this [JoinResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JoinResult copyWith({
    _ilhd52bb.EventPublic? event,
    _ih9iep0x.Guest? guest,
    _isc.UuidValue? albumSpaceId,
    Object? recoveryKey = _Undefined,
  }) {
    return JoinResult(
      event: event ?? this.event.copyWith(),
      guest: guest ?? this.guest.copyWith(),
      albumSpaceId: albumSpaceId ?? this.albumSpaceId,
      recoveryKey: recoveryKey is String? ? recoveryKey : this.recoveryKey,
    );
  }
}
