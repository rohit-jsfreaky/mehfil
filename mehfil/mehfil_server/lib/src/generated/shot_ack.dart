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
import 'package:serverpod/serverpod.dart' as _is;

/// The server's answer to an upload. [duplicate] is true when the shot had
/// already arrived (a retry after a dropped connection).
abstract class ShotAck
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ShotAck._({
    required this.shotId,
    required this.receivedAt,
    required this.duplicate,
  });

  factory ShotAck({
    required _is.UuidValue shotId,
    required DateTime receivedAt,
    required bool duplicate,
  }) = _ShotAckImpl;

  factory ShotAck.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShotAck(
      shotId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['shotId']),
      receivedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
      duplicate: _is.BoolJsonExtension.fromJson(jsonSerialization['duplicate']),
    );
  }

  _is.UuidValue shotId;

  DateTime receivedAt;

  bool duplicate;

  /// Returns a shallow copy of this [ShotAck]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ShotAck copyWith({
    _is.UuidValue? shotId,
    DateTime? receivedAt,
    bool? duplicate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShotAck',
      'shotId': shotId.toJson(),
      'receivedAt': receivedAt.toJson(),
      'duplicate': duplicate,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ShotAck',
      'shotId': shotId.toJson(),
      'receivedAt': receivedAt.toJson(),
      'duplicate': duplicate,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ShotAckImpl extends ShotAck {
  _ShotAckImpl({
    required _is.UuidValue shotId,
    required DateTime receivedAt,
    required bool duplicate,
  }) : super._(
         shotId: shotId,
         receivedAt: receivedAt,
         duplicate: duplicate,
       );

  /// Returns a shallow copy of this [ShotAck]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ShotAck copyWith({
    _is.UuidValue? shotId,
    DateTime? receivedAt,
    bool? duplicate,
  }) {
    return ShotAck(
      shotId: shotId ?? this.shotId,
      receivedAt: receivedAt ?? this.receivedAt,
      duplicate: duplicate ?? this.duplicate,
    );
  }
}
