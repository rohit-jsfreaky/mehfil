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

/// One row per revealed roll. The unique index is what makes a reveal happen
/// exactly once, whoever triggers it (the future call or the host).
abstract class RevealLog
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RevealLog._({
    this.id,
    required this.rollId,
    required this.trigger,
    required this.photos,
    required this.revealedAt,
  });

  factory RevealLog({
    int? id,
    required int rollId,
    required String trigger,
    required int photos,
    required DateTime revealedAt,
  }) = _RevealLogImpl;

  factory RevealLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return RevealLog(
      id: jsonSerialization['id'] as int?,
      rollId: jsonSerialization['rollId'] as int,
      trigger: jsonSerialization['trigger'] as String,
      photos: jsonSerialization['photos'] as int,
      revealedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['revealedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int rollId;

  /// "schedule" (the future call) or "host" (Reveal now).
  String trigger;

  int photos;

  DateTime revealedAt;

  /// Returns a shallow copy of this [RevealLog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RevealLog copyWith({
    int? id,
    int? rollId,
    String? trigger,
    int? photos,
    DateTime? revealedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RevealLog',
      if (id != null) 'id': id,
      'rollId': rollId,
      'trigger': trigger,
      'photos': photos,
      'revealedAt': revealedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RevealLog',
      if (id != null) 'id': id,
      'rollId': rollId,
      'trigger': trigger,
      'photos': photos,
      'revealedAt': revealedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RevealLogImpl extends RevealLog {
  _RevealLogImpl({
    int? id,
    required int rollId,
    required String trigger,
    required int photos,
    required DateTime revealedAt,
  }) : super._(
         id: id,
         rollId: rollId,
         trigger: trigger,
         photos: photos,
         revealedAt: revealedAt,
       );

  /// Returns a shallow copy of this [RevealLog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RevealLog copyWith({
    Object? id = _Undefined,
    int? rollId,
    String? trigger,
    int? photos,
    DateTime? revealedAt,
  }) {
    return RevealLog(
      id: id is int? ? id : this.id,
      rollId: rollId ?? this.rollId,
      trigger: trigger ?? this.trigger,
      photos: photos ?? this.photos,
      revealedAt: revealedAt ?? this.revealedAt,
    );
  }
}
