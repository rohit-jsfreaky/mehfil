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

/// One line on the wall: "Bua sent 3 photos" or "Kabir joined". Names and
/// counts only, never a photo.
abstract class WallActivity
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WallActivity._({
    required this.name,
    required this.kind,
    required this.count,
    required this.at,
  });

  factory WallActivity({
    required String name,
    required String kind,
    required int count,
    required DateTime at,
  }) = _WallActivityImpl;

  factory WallActivity.fromJson(Map<String, dynamic> jsonSerialization) {
    return WallActivity(
      name: jsonSerialization['name'] as String,
      kind: jsonSerialization['kind'] as String,
      count: jsonSerialization['count'] as int,
      at: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  String name;

  /// "photos" or "joined".
  String kind;

  int count;

  DateTime at;

  /// Returns a shallow copy of this [WallActivity]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WallActivity copyWith({
    String? name,
    String? kind,
    int? count,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WallActivity',
      'name': name,
      'kind': kind,
      'count': count,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WallActivity',
      'name': name,
      'kind': kind,
      'count': count,
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _WallActivityImpl extends WallActivity {
  _WallActivityImpl({
    required String name,
    required String kind,
    required int count,
    required DateTime at,
  }) : super._(
         name: name,
         kind: kind,
         count: count,
         at: at,
       );

  /// Returns a shallow copy of this [WallActivity]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WallActivity copyWith({
    String? name,
    String? kind,
    int? count,
    DateTime? at,
  }) {
    return WallActivity(
      name: name ?? this.name,
      kind: kind ?? this.kind,
      count: count ?? this.count,
      at: at ?? this.at,
    );
  }
}
