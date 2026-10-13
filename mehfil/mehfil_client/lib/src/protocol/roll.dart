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

/// One function of the event (Haldi, Sangeet...). Its photos stay hidden until
/// [revealAt]; the reveal future call sets [revealedAt].
abstract class Roll
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Roll._({
    this.id,
    required this.eventId,
    required this.name,
    int? sortOrder,
    required this.revealAt,
    this.revealedAt,
    int? shotsPerGuest,
  }) : sortOrder = sortOrder ?? 0,
       shotsPerGuest = shotsPerGuest ?? 27;

  factory Roll({
    int? id,
    required int eventId,
    required String name,
    int? sortOrder,
    required DateTime revealAt,
    DateTime? revealedAt,
    int? shotsPerGuest,
  }) = _RollImpl;

  factory Roll.fromJson(Map<String, dynamic> jsonSerialization) {
    return Roll(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      name: jsonSerialization['name'] as String,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      revealAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['revealAt'],
      ),
      revealedAt: jsonSerialization['revealedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['revealedAt'],
            ),
      shotsPerGuest: jsonSerialization['shotsPerGuest'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int eventId;

  String name;

  int sortOrder;

  /// Server time (UTC) when the album opens for everyone.
  DateTime revealAt;

  /// Set once, by the reveal. Null means the roll is still hidden.
  DateTime? revealedAt;

  /// Like a disposable camera: how many shots each guest gets on this roll.
  int shotsPerGuest;

  /// Returns a shallow copy of this [Roll]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Roll copyWith({
    int? id,
    int? eventId,
    String? name,
    int? sortOrder,
    DateTime? revealAt,
    DateTime? revealedAt = const _isc.$UndefinedDateTime(),
    int? shotsPerGuest,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Roll',
      if (id != null) 'id': id,
      'eventId': eventId,
      'name': name,
      'sortOrder': sortOrder,
      'revealAt': revealAt.toJson(),
      if (revealedAt != null) 'revealedAt': revealedAt?.toJson(),
      'shotsPerGuest': shotsPerGuest,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Roll',
      if (id != null) 'id': id,
      'eventId': eventId,
      'name': name,
      'sortOrder': sortOrder,
      'revealAt': revealAt.toJson(),
      if (revealedAt != null) 'revealedAt': revealedAt?.toJson(),
      'shotsPerGuest': shotsPerGuest,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RollImpl extends Roll {
  _RollImpl({
    int? id,
    required int eventId,
    required String name,
    int? sortOrder,
    required DateTime revealAt,
    DateTime? revealedAt,
    int? shotsPerGuest,
  }) : super._(
         id: id,
         eventId: eventId,
         name: name,
         sortOrder: sortOrder,
         revealAt: revealAt,
         revealedAt: revealedAt,
         shotsPerGuest: shotsPerGuest,
       );

  /// Returns a shallow copy of this [Roll]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Roll copyWith({
    Object? id = _Undefined,
    int? eventId,
    String? name,
    int? sortOrder,
    DateTime? revealAt,
    DateTime? revealedAt = const _isc.$UndefinedDateTime(),
    int? shotsPerGuest,
  }) {
    return Roll(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      revealAt: revealAt ?? this.revealAt,
      revealedAt: revealedAt is _isc.UndefinedSentinel
          ? this.revealedAt
          : revealedAt,
      shotsPerGuest: shotsPerGuest ?? this.shotsPerGuest,
    );
  }
}
