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

abstract class MehfilException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  MehfilException._({
    required this.code,
    required this.message,
  });

  factory MehfilException({
    required String code,
    required String message,
  }) = _MehfilExceptionImpl;

  factory MehfilException.fromJson(Map<String, dynamic> jsonSerialization) {
    return MehfilException(
      code: jsonSerialization['code'] as String,
      message: jsonSerialization['message'] as String,
    );
  }

  String code;

  String message;

  /// Returns a shallow copy of this [MehfilException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MehfilException copyWith({
    String? code,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MehfilException',
      'code': code,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MehfilException',
      'code': code,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'MehfilException(code: $code, message: $message)';
  }
}

class _MehfilExceptionImpl extends MehfilException {
  _MehfilExceptionImpl({
    required String code,
    required String message,
  }) : super._(
         code: code,
         message: message,
       );

  /// Returns a shallow copy of this [MehfilException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MehfilException copyWith({
    String? code,
    String? message,
  }) {
    return MehfilException(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}
