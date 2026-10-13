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
import 'package:mehfil_client/src/protocol/protocol.dart' as _iyjh1ba9;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'guest_delivery.dart' as _ig33w2mv;

/// For the host and the evidence files: what the server really holds.
/// A shot is "delivered" only when its synced row AND its file are here.
abstract class DeliveryReport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DeliveryReport._({
    required this.eventId,
    required this.rowsSynced,
    required this.filesReceived,
    required this.delivered,
    required this.rowsWithoutFile,
    required this.filesWithoutRow,
    required this.guests,
    required this.serverNow,
    int? waitedOverMinute,
    int? longestWaitSeconds,
  }) : waitedOverMinute = waitedOverMinute ?? 0,
       longestWaitSeconds = longestWaitSeconds ?? 0;

  factory DeliveryReport({
    required int eventId,
    required int rowsSynced,
    required int filesReceived,
    required int delivered,
    required int rowsWithoutFile,
    required int filesWithoutRow,
    required List<_ig33w2mv.GuestDelivery> guests,
    required DateTime serverNow,
    int? waitedOverMinute,
    int? longestWaitSeconds,
  }) = _DeliveryReportImpl;

  factory DeliveryReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeliveryReport(
      eventId: jsonSerialization['eventId'] as int,
      rowsSynced: jsonSerialization['rowsSynced'] as int,
      filesReceived: jsonSerialization['filesReceived'] as int,
      delivered: jsonSerialization['delivered'] as int,
      rowsWithoutFile: jsonSerialization['rowsWithoutFile'] as int,
      filesWithoutRow: jsonSerialization['filesWithoutRow'] as int,
      guests: _iyjh1ba9.Protocol().deserialize<List<_ig33w2mv.GuestDelivery>>(
        jsonSerialization['guests'],
      ),
      serverNow: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverNow'],
      ),
      waitedOverMinute: jsonSerialization['waitedOverMinute'] as int?,
      longestWaitSeconds: jsonSerialization['longestWaitSeconds'] as int?,
    );
  }

  int eventId;

  int rowsSynced;

  int filesReceived;

  int delivered;

  int rowsWithoutFile;

  int filesWithoutRow;

  List<_ig33w2mv.GuestDelivery> guests;

  DateTime serverNow;

  /// Photos that reached the server more than a minute after the phone took
  /// them (server receivedAt minus the phone's takenAt claim): they waited
  /// on the phone, usually for signal.
  int waitedOverMinute;

  /// Longest wait in seconds (same measure).
  int longestWaitSeconds;

  /// Returns a shallow copy of this [DeliveryReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DeliveryReport copyWith({
    int? eventId,
    int? rowsSynced,
    int? filesReceived,
    int? delivered,
    int? rowsWithoutFile,
    int? filesWithoutRow,
    List<_ig33w2mv.GuestDelivery>? guests,
    DateTime? serverNow,
    int? waitedOverMinute,
    int? longestWaitSeconds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeliveryReport',
      'eventId': eventId,
      'rowsSynced': rowsSynced,
      'filesReceived': filesReceived,
      'delivered': delivered,
      'rowsWithoutFile': rowsWithoutFile,
      'filesWithoutRow': filesWithoutRow,
      'guests': guests.toJson(valueToJson: (v) => v.toJson()),
      'serverNow': serverNow.toJson(),
      'waitedOverMinute': waitedOverMinute,
      'longestWaitSeconds': longestWaitSeconds,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeliveryReport',
      'eventId': eventId,
      'rowsSynced': rowsSynced,
      'filesReceived': filesReceived,
      'delivered': delivered,
      'rowsWithoutFile': rowsWithoutFile,
      'filesWithoutRow': filesWithoutRow,
      'guests': guests.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'serverNow': serverNow.toJson(),
      'waitedOverMinute': waitedOverMinute,
      'longestWaitSeconds': longestWaitSeconds,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DeliveryReportImpl extends DeliveryReport {
  _DeliveryReportImpl({
    required int eventId,
    required int rowsSynced,
    required int filesReceived,
    required int delivered,
    required int rowsWithoutFile,
    required int filesWithoutRow,
    required List<_ig33w2mv.GuestDelivery> guests,
    required DateTime serverNow,
    int? waitedOverMinute,
    int? longestWaitSeconds,
  }) : super._(
         eventId: eventId,
         rowsSynced: rowsSynced,
         filesReceived: filesReceived,
         delivered: delivered,
         rowsWithoutFile: rowsWithoutFile,
         filesWithoutRow: filesWithoutRow,
         guests: guests,
         serverNow: serverNow,
         waitedOverMinute: waitedOverMinute,
         longestWaitSeconds: longestWaitSeconds,
       );

  /// Returns a shallow copy of this [DeliveryReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DeliveryReport copyWith({
    int? eventId,
    int? rowsSynced,
    int? filesReceived,
    int? delivered,
    int? rowsWithoutFile,
    int? filesWithoutRow,
    List<_ig33w2mv.GuestDelivery>? guests,
    DateTime? serverNow,
    int? waitedOverMinute,
    int? longestWaitSeconds,
  }) {
    return DeliveryReport(
      eventId: eventId ?? this.eventId,
      rowsSynced: rowsSynced ?? this.rowsSynced,
      filesReceived: filesReceived ?? this.filesReceived,
      delivered: delivered ?? this.delivered,
      rowsWithoutFile: rowsWithoutFile ?? this.rowsWithoutFile,
      filesWithoutRow: filesWithoutRow ?? this.filesWithoutRow,
      guests: guests ?? this.guests.map((e0) => e0.copyWith()).toList(),
      serverNow: serverNow ?? this.serverNow,
      waitedOverMinute: waitedOverMinute ?? this.waitedOverMinute,
      longestWaitSeconds: longestWaitSeconds ?? this.longestWaitSeconds,
    );
  }
}
