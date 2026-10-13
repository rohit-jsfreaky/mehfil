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

abstract class GuestDelivery
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  GuestDelivery._({
    required this.name,
    required this.rowsSynced,
    required this.filesReceived,
    required this.delivered,
  });

  factory GuestDelivery({
    required String name,
    required int rowsSynced,
    required int filesReceived,
    required int delivered,
  }) = _GuestDeliveryImpl;

  factory GuestDelivery.fromJson(Map<String, dynamic> jsonSerialization) {
    return GuestDelivery(
      name: jsonSerialization['name'] as String,
      rowsSynced: jsonSerialization['rowsSynced'] as int,
      filesReceived: jsonSerialization['filesReceived'] as int,
      delivered: jsonSerialization['delivered'] as int,
    );
  }

  String name;

  int rowsSynced;

  int filesReceived;

  int delivered;

  /// Returns a shallow copy of this [GuestDelivery]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  GuestDelivery copyWith({
    String? name,
    int? rowsSynced,
    int? filesReceived,
    int? delivered,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GuestDelivery',
      'name': name,
      'rowsSynced': rowsSynced,
      'filesReceived': filesReceived,
      'delivered': delivered,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GuestDelivery',
      'name': name,
      'rowsSynced': rowsSynced,
      'filesReceived': filesReceived,
      'delivered': delivered,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _GuestDeliveryImpl extends GuestDelivery {
  _GuestDeliveryImpl({
    required String name,
    required int rowsSynced,
    required int filesReceived,
    required int delivered,
  }) : super._(
         name: name,
         rowsSynced: rowsSynced,
         filesReceived: filesReceived,
         delivered: delivered,
       );

  /// Returns a shallow copy of this [GuestDelivery]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  GuestDelivery copyWith({
    String? name,
    int? rowsSynced,
    int? filesReceived,
    int? delivered,
  }) {
    return GuestDelivery(
      name: name ?? this.name,
      rowsSynced: rowsSynced ?? this.rowsSynced,
      filesReceived: filesReceived ?? this.filesReceived,
      delivered: delivered ?? this.delivered,
    );
  }
}
