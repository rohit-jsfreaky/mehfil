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
import 'dart:typed_data' as _idt;
import 'package:serverpod/serverpod.dart' as _is;

/// The phone-side queue: the photo bytes wait here (SQLite on the device, or
/// in the browser) until the server confirms it has them.
abstract class PendingUpload
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PendingUpload._({
    this.id,
    required this.shotId,
    required this.eventId,
    required this.rollId,
    required this.bytes,
    required this.createdAt,
    int? attempts,
    this.lastError,
  }) : attempts = attempts ?? 0;

  factory PendingUpload({
    int? id,
    required _is.UuidValue shotId,
    required int eventId,
    required int rollId,
    required _idt.ByteData bytes,
    required DateTime createdAt,
    int? attempts,
    String? lastError,
  }) = _PendingUploadImpl;

  factory PendingUpload.fromJson(Map<String, dynamic> jsonSerialization) {
    return PendingUpload(
      id: jsonSerialization['id'] as int?,
      shotId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['shotId']),
      eventId: jsonSerialization['eventId'] as int,
      rollId: jsonSerialization['rollId'] as int,
      bytes: _is.ByteDataJsonExtension.fromJson(jsonSerialization['bytes']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      attempts: jsonSerialization['attempts'] as int?,
      lastError: jsonSerialization['lastError'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _is.UuidValue shotId;

  int eventId;

  int rollId;

  _idt.ByteData bytes;

  DateTime createdAt;

  int attempts;

  String? lastError;

  /// Returns a shallow copy of this [PendingUpload]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PendingUpload copyWith({
    int? id,
    _is.UuidValue? shotId,
    int? eventId,
    int? rollId,
    _idt.ByteData? bytes,
    DateTime? createdAt,
    int? attempts,
    String? lastError,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PendingUpload',
      if (id != null) 'id': id,
      'shotId': shotId.toJson(),
      'eventId': eventId,
      'rollId': rollId,
      'bytes': bytes.toJson(),
      'createdAt': createdAt.toJson(),
      'attempts': attempts,
      if (lastError != null) 'lastError': lastError,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PendingUpload',
      if (id != null) 'id': id,
      'shotId': shotId.toJson(),
      'eventId': eventId,
      'rollId': rollId,
      'bytes': bytes.toJson(),
      'createdAt': createdAt.toJson(),
      'attempts': attempts,
      if (lastError != null) 'lastError': lastError,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PendingUploadImpl extends PendingUpload {
  _PendingUploadImpl({
    int? id,
    required _is.UuidValue shotId,
    required int eventId,
    required int rollId,
    required _idt.ByteData bytes,
    required DateTime createdAt,
    int? attempts,
    String? lastError,
  }) : super._(
         id: id,
         shotId: shotId,
         eventId: eventId,
         rollId: rollId,
         bytes: bytes,
         createdAt: createdAt,
         attempts: attempts,
         lastError: lastError,
       );

  /// Returns a shallow copy of this [PendingUpload]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PendingUpload copyWith({
    Object? id = _Undefined,
    _is.UuidValue? shotId,
    int? eventId,
    int? rollId,
    _idt.ByteData? bytes,
    DateTime? createdAt,
    int? attempts,
    Object? lastError = _Undefined,
  }) {
    return PendingUpload(
      id: id is int? ? id : this.id,
      shotId: shotId ?? this.shotId,
      eventId: eventId ?? this.eventId,
      rollId: rollId ?? this.rollId,
      bytes: bytes ?? this.bytes.clone(),
      createdAt: createdAt ?? this.createdAt,
      attempts: attempts ?? this.attempts,
      lastError: lastError is String? ? lastError : this.lastError,
    );
  }
}
