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

/// A gathering (a wedding, a dinner). The host owns it; guests join it with
/// [joinCode] from the QR.
abstract class Event
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Event._({
    this.id,
    required this.name,
    this.hostedBy,
    required this.joinCode,
    required this.hostUserId,
    required this.albumSpaceId,
    bool? isDemo,
    DateTime? createdAt,
  }) : isDemo = isDemo ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Event({
    int? id,
    required String name,
    String? hostedBy,
    required String joinCode,
    required _isc.UuidValue hostUserId,
    required _isc.UuidValue albumSpaceId,
    bool? isDemo,
    DateTime? createdAt,
  }) = _EventImpl;

  factory Event.fromJson(Map<String, dynamic> jsonSerialization) {
    return Event(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      hostedBy: jsonSerialization['hostedBy'] as String?,
      joinCode: jsonSerialization['joinCode'] as String,
      hostUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['hostUserId'],
      ),
      albumSpaceId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['albumSpaceId'],
      ),
      isDemo: jsonSerialization['isDemo'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  /// Shown on the invitation: "Hosted by the Sharma family".
  String? hostedBy;

  /// Short code in the QR link. Also the token the anonymous sign-in checks.
  String joinCode;

  /// The auth user id of the host who created the event.
  _isc.UuidValue hostUserId;

  /// Offline sync space that holds the revealed album. Guests become
  /// read-only members of it when the first roll is revealed.
  _isc.UuidValue albumSpaceId;

  /// Events seeded for the video or for judges are labelled demo.
  bool isDemo;

  DateTime createdAt;

  /// Returns a shallow copy of this [Event]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Event copyWith({
    int? id,
    String? name,
    String? hostedBy,
    String? joinCode,
    _isc.UuidValue? hostUserId,
    _isc.UuidValue? albumSpaceId,
    bool? isDemo,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Event',
      if (id != null) 'id': id,
      'name': name,
      if (hostedBy != null) 'hostedBy': hostedBy,
      'joinCode': joinCode,
      'hostUserId': hostUserId.toJson(),
      'albumSpaceId': albumSpaceId.toJson(),
      'isDemo': isDemo,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Event',
      if (id != null) 'id': id,
      'name': name,
      if (hostedBy != null) 'hostedBy': hostedBy,
      'joinCode': joinCode,
      'hostUserId': hostUserId.toJson(),
      'albumSpaceId': albumSpaceId.toJson(),
      'isDemo': isDemo,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventImpl extends Event {
  _EventImpl({
    int? id,
    required String name,
    String? hostedBy,
    required String joinCode,
    required _isc.UuidValue hostUserId,
    required _isc.UuidValue albumSpaceId,
    bool? isDemo,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         hostedBy: hostedBy,
         joinCode: joinCode,
         hostUserId: hostUserId,
         albumSpaceId: albumSpaceId,
         isDemo: isDemo,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Event]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Event copyWith({
    Object? id = _Undefined,
    String? name,
    Object? hostedBy = _Undefined,
    String? joinCode,
    _isc.UuidValue? hostUserId,
    _isc.UuidValue? albumSpaceId,
    bool? isDemo,
    DateTime? createdAt,
  }) {
    return Event(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      hostedBy: hostedBy is String? ? hostedBy : this.hostedBy,
      joinCode: joinCode ?? this.joinCode,
      hostUserId: hostUserId ?? this.hostUserId,
      albumSpaceId: albumSpaceId ?? this.albumSpaceId,
      isDemo: isDemo ?? this.isDemo,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
