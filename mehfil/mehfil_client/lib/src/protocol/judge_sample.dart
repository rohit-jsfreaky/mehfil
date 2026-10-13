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

/// A real, still-hidden photo of a DEMO event, so judges can try to open it
/// and watch the server refuse.
abstract class JudgeSample
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JudgeSample._({
    required this.shotId,
    required this.eventId,
    required this.rollId,
    required this.guessedPath,
  });

  factory JudgeSample({
    required _isc.UuidValue shotId,
    required int eventId,
    required int rollId,
    required String guessedPath,
  }) = _JudgeSampleImpl;

  factory JudgeSample.fromJson(Map<String, dynamic> jsonSerialization) {
    return JudgeSample(
      shotId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['shotId']),
      eventId: jsonSerialization['eventId'] as int,
      rollId: jsonSerialization['rollId'] as int,
      guessedPath: jsonSerialization['guessedPath'] as String,
    );
  }

  _isc.UuidValue shotId;

  int eventId;

  int rollId;

  String guessedPath;

  /// Returns a shallow copy of this [JudgeSample]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JudgeSample copyWith({
    _isc.UuidValue? shotId,
    int? eventId,
    int? rollId,
    String? guessedPath,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JudgeSample',
      'shotId': shotId.toJson(),
      'eventId': eventId,
      'rollId': rollId,
      'guessedPath': guessedPath,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JudgeSample',
      'shotId': shotId.toJson(),
      'eventId': eventId,
      'rollId': rollId,
      'guessedPath': guessedPath,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _JudgeSampleImpl extends JudgeSample {
  _JudgeSampleImpl({
    required _isc.UuidValue shotId,
    required int eventId,
    required int rollId,
    required String guessedPath,
  }) : super._(
         shotId: shotId,
         eventId: eventId,
         rollId: rollId,
         guessedPath: guessedPath,
       );

  /// Returns a shallow copy of this [JudgeSample]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JudgeSample copyWith({
    _isc.UuidValue? shotId,
    int? eventId,
    int? rollId,
    String? guessedPath,
  }) {
    return JudgeSample(
      shotId: shotId ?? this.shotId,
      eventId: eventId ?? this.eventId,
      rollId: rollId ?? this.rollId,
      guessedPath: guessedPath ?? this.guessedPath,
    );
  }
}
