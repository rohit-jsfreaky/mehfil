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

/// A person who joined an event from the QR (anonymous sign-in + a name).
abstract class Guest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Guest._({
    this.id,
    required this.eventId,
    required this.authUserId,
    required this.name,
    DateTime? joinedAt,
  }) : joinedAt = joinedAt ?? DateTime.now();

  factory Guest({
    int? id,
    required int eventId,
    required _isc.UuidValue authUserId,
    required String name,
    DateTime? joinedAt,
  }) = _GuestImpl;

  factory Guest.fromJson(Map<String, dynamic> jsonSerialization) {
    return Guest(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      name: jsonSerialization['name'] as String,
      joinedAt: jsonSerialization['joinedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int eventId;

  _isc.UuidValue authUserId;

  String name;

  DateTime joinedAt;

  /// Returns a shallow copy of this [Guest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Guest copyWith({
    int? id,
    int? eventId,
    _isc.UuidValue? authUserId,
    String? name,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Guest',
      if (id != null) 'id': id,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'name': name,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Guest',
      if (id != null) 'id': id,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'name': name,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GuestImpl extends Guest {
  _GuestImpl({
    int? id,
    required int eventId,
    required _isc.UuidValue authUserId,
    required String name,
    DateTime? joinedAt,
  }) : super._(
         id: id,
         eventId: eventId,
         authUserId: authUserId,
         name: name,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [Guest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Guest copyWith({
    Object? id = _Undefined,
    int? eventId,
    _isc.UuidValue? authUserId,
    String? name,
    DateTime? joinedAt,
  }) {
    return Guest(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      authUserId: authUserId ?? this.authUserId,
      name: name ?? this.name,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
