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

abstract class RollCount
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RollCount._({
    required this.rollId,
    required this.name,
    required this.revealAt,
    this.revealedAt,
    required this.photos,
    required this.guests,
  });

  factory RollCount({
    required int rollId,
    required String name,
    required DateTime revealAt,
    DateTime? revealedAt,
    required int photos,
    required int guests,
  }) = _RollCountImpl;

  factory RollCount.fromJson(Map<String, dynamic> jsonSerialization) {
    return RollCount(
      rollId: jsonSerialization['rollId'] as int,
      name: jsonSerialization['name'] as String,
      revealAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['revealAt'],
      ),
      revealedAt: jsonSerialization['revealedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['revealedAt'],
            ),
      photos: jsonSerialization['photos'] as int,
      guests: jsonSerialization['guests'] as int,
    );
  }

  int rollId;

  String name;

  DateTime revealAt;

  DateTime? revealedAt;

  int photos;

  int guests;

  /// Returns a shallow copy of this [RollCount]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RollCount copyWith({
    int? rollId,
    String? name,
    DateTime? revealAt,
    DateTime? revealedAt = const _isc.$UndefinedDateTime(),
    int? photos,
    int? guests,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RollCount',
      'rollId': rollId,
      'name': name,
      'revealAt': revealAt.toJson(),
      if (revealedAt != null) 'revealedAt': revealedAt?.toJson(),
      'photos': photos,
      'guests': guests,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RollCount',
      'rollId': rollId,
      'name': name,
      'revealAt': revealAt.toJson(),
      if (revealedAt != null) 'revealedAt': revealedAt?.toJson(),
      'photos': photos,
      'guests': guests,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _RollCountImpl extends RollCount {
  _RollCountImpl({
    required int rollId,
    required String name,
    required DateTime revealAt,
    DateTime? revealedAt,
    required int photos,
    required int guests,
  }) : super._(
         rollId: rollId,
         name: name,
         revealAt: revealAt,
         revealedAt: revealedAt,
         photos: photos,
         guests: guests,
       );

  /// Returns a shallow copy of this [RollCount]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RollCount copyWith({
    int? rollId,
    String? name,
    DateTime? revealAt,
    DateTime? revealedAt = const _isc.$UndefinedDateTime(),
    int? photos,
    int? guests,
  }) {
    return RollCount(
      rollId: rollId ?? this.rollId,
      name: name ?? this.name,
      revealAt: revealAt ?? this.revealAt,
      revealedAt: revealedAt is _isc.UndefinedSentinel
          ? this.revealedAt
          : revealedAt,
      photos: photos ?? this.photos,
      guests: guests ?? this.guests,
    );
  }
}
