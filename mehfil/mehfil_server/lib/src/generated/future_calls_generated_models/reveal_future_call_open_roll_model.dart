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

abstract class RevealFutureCallOpenRollModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  RevealFutureCallOpenRollModel._({required this.rollId});

  factory RevealFutureCallOpenRollModel({required int rollId}) =
      _RevealFutureCallOpenRollModelImpl;

  factory RevealFutureCallOpenRollModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return RevealFutureCallOpenRollModel(
      rollId: jsonSerialization['rollId'] as int,
    );
  }

  int rollId;

  /// Returns a shallow copy of this [RevealFutureCallOpenRollModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RevealFutureCallOpenRollModel copyWith({int? rollId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RevealFutureCallOpenRollModel',
      'rollId': rollId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _RevealFutureCallOpenRollModelImpl extends RevealFutureCallOpenRollModel {
  _RevealFutureCallOpenRollModelImpl({required int rollId})
    : super._(rollId: rollId);

  /// Returns a shallow copy of this [RevealFutureCallOpenRollModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RevealFutureCallOpenRollModel copyWith({int? rollId}) {
    return RevealFutureCallOpenRollModel(rollId: rollId ?? this.rollId);
  }
}
