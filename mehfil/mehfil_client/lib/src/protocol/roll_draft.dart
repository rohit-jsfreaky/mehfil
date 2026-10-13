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

abstract class RollDraft
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RollDraft._({
    required this.name,
    required this.revealAt,
    int? shotsPerGuest,
  }) : shotsPerGuest = shotsPerGuest ?? 27;

  factory RollDraft({
    required String name,
    required DateTime revealAt,
    int? shotsPerGuest,
  }) = _RollDraftImpl;

  factory RollDraft.fromJson(Map<String, dynamic> jsonSerialization) {
    return RollDraft(
      name: jsonSerialization['name'] as String,
      revealAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['revealAt'],
      ),
      shotsPerGuest: jsonSerialization['shotsPerGuest'] as int?,
    );
  }

  String name;

  DateTime revealAt;

  int shotsPerGuest;

  /// Returns a shallow copy of this [RollDraft]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RollDraft copyWith({
    String? name,
    DateTime? revealAt,
    int? shotsPerGuest,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RollDraft',
      'name': name,
      'revealAt': revealAt.toJson(),
      'shotsPerGuest': shotsPerGuest,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RollDraft',
      'name': name,
      'revealAt': revealAt.toJson(),
      'shotsPerGuest': shotsPerGuest,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _RollDraftImpl extends RollDraft {
  _RollDraftImpl({
    required String name,
    required DateTime revealAt,
    int? shotsPerGuest,
  }) : super._(
         name: name,
         revealAt: revealAt,
         shotsPerGuest: shotsPerGuest,
       );

  /// Returns a shallow copy of this [RollDraft]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RollDraft copyWith({
    String? name,
    DateTime? revealAt,
    int? shotsPerGuest,
  }) {
    return RollDraft(
      name: name ?? this.name,
      revealAt: revealAt ?? this.revealAt,
      shotsPerGuest: shotsPerGuest ?? this.shotsPerGuest,
    );
  }
}
