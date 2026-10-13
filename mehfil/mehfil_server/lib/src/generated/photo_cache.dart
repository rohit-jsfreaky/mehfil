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

/// Phone-side copy of revealed photos, so the album opens with no signal.
abstract class PhotoCache
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PhotoCache._({
    this.id,
    required this.shotId,
    required this.thumb,
    required this.bytes,
    required this.savedAt,
  });

  factory PhotoCache({
    int? id,
    required _is.UuidValue shotId,
    required bool thumb,
    required _idt.ByteData bytes,
    required DateTime savedAt,
  }) = _PhotoCacheImpl;

  factory PhotoCache.fromJson(Map<String, dynamic> jsonSerialization) {
    return PhotoCache(
      id: jsonSerialization['id'] as int?,
      shotId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['shotId']),
      thumb: _is.BoolJsonExtension.fromJson(jsonSerialization['thumb']),
      bytes: _is.ByteDataJsonExtension.fromJson(jsonSerialization['bytes']),
      savedAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['savedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _is.UuidValue shotId;

  bool thumb;

  _idt.ByteData bytes;

  DateTime savedAt;

  /// Returns a shallow copy of this [PhotoCache]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PhotoCache copyWith({
    int? id,
    _is.UuidValue? shotId,
    bool? thumb,
    _idt.ByteData? bytes,
    DateTime? savedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PhotoCache',
      if (id != null) 'id': id,
      'shotId': shotId.toJson(),
      'thumb': thumb,
      'bytes': bytes.toJson(),
      'savedAt': savedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PhotoCache',
      if (id != null) 'id': id,
      'shotId': shotId.toJson(),
      'thumb': thumb,
      'bytes': bytes.toJson(),
      'savedAt': savedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PhotoCacheImpl extends PhotoCache {
  _PhotoCacheImpl({
    int? id,
    required _is.UuidValue shotId,
    required bool thumb,
    required _idt.ByteData bytes,
    required DateTime savedAt,
  }) : super._(
         id: id,
         shotId: shotId,
         thumb: thumb,
         bytes: bytes,
         savedAt: savedAt,
       );

  /// Returns a shallow copy of this [PhotoCache]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PhotoCache copyWith({
    Object? id = _Undefined,
    _is.UuidValue? shotId,
    bool? thumb,
    _idt.ByteData? bytes,
    DateTime? savedAt,
  }) {
    return PhotoCache(
      id: id is int? ? id : this.id,
      shotId: shotId ?? this.shotId,
      thumb: thumb ?? this.thumb,
      bytes: bytes ?? this.bytes.clone(),
      savedAt: savedAt ?? this.savedAt,
    );
  }
}
