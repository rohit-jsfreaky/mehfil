/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mehfil_client/src/protocol/album_photo.dart' as _ieq0999k;
import 'package:mehfil_client/src/protocol/host_event.dart' as _icm8qwqy;
import 'package:mehfil_client/src/protocol/reveal_log.dart' as _irqmjged;
import 'package:mehfil_client/src/protocol/roll_draft.dart' as _i4s7sdo1;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart'
    as _ipulbpi2;
import 'album_photo.dart' as _i04o2qcx;
import 'delivery_report.dart' as _i17f5dfe;
import 'event.dart' as _iu57571s;
import 'event_public.dart' as _ilhd52bb;
import 'guest.dart' as _ih9iep0x;
import 'guest_delivery.dart' as _ig33w2mv;
import 'host_event.dart' as _i2nfd3jx;
import 'join_result.dart' as _irdkvnmr;
import 'judge_sample.dart' as _iqidd2u5;
import 'mehfil_exception.dart' as _i7llcmuq;
import 'pending_upload.dart' as _idi3lhss;
import 'photo_cache.dart' as _imh0m85v;
import 'reveal_log.dart' as _inreqcmk;
import 'roll.dart' as _iizodh34;
import 'roll_count.dart' as _i33oi965;
import 'roll_draft.dart' as _ilgienw1;
import 'shot.dart' as _ikzltuid;
import 'shot_ack.dart' as _i0ulujow;
import 'wall.dart' as _ibn1yndy;
import 'wall_activity.dart' as _i0jjlicg;
import 'wall_tick.dart' as _if8194bu;
export 'album_photo.dart';
export 'delivery_report.dart';
export 'event.dart';
export 'event_public.dart';
export 'guest.dart';
export 'guest_delivery.dart';
export 'host_event.dart';
export 'join_result.dart';
export 'judge_sample.dart';
export 'mehfil_exception.dart';
export 'pending_upload.dart';
export 'photo_cache.dart';
export 'reveal_log.dart';
export 'roll.dart';
export 'roll_count.dart';
export 'roll_draft.dart';
export 'shot.dart';
export 'shot_ack.dart';
export 'wall.dart';
export 'wall_activity.dart';
export 'wall_tick.dart';
export 'client.dart';
export 'sync_tables.dart';

class Protocol extends _isd.DatabaseSerializationManager
    implements _isd.DatabaseProtocolDeserializationProvider {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  @override
  _isc.ProtocolDeserialization get deserializationMetadata =>
      _isc.ProtocolDeserialization.cached(
        this,
        types: const [
          _isc.getType<_i04o2qcx.AlbumPhoto>,
          _isc.getType<_i17f5dfe.DeliveryReport>,
          _isc.getType<_iu57571s.Event>,
          _isc.getType<_ilhd52bb.EventPublic>,
          _isc.getType<_ih9iep0x.Guest>,
          _isc.getType<_ig33w2mv.GuestDelivery>,
          _isc.getType<_i2nfd3jx.HostEvent>,
          _isc.getType<_irdkvnmr.JoinResult>,
          _isc.getType<_iqidd2u5.JudgeSample>,
          _isc.getType<_i7llcmuq.MehfilException>,
          _isc.getType<_idi3lhss.PendingUpload>,
          _isc.getType<_imh0m85v.PhotoCache>,
          _isc.getType<_inreqcmk.RevealLog>,
          _isc.getType<_iizodh34.Roll>,
          _isc.getType<_i33oi965.RollCount>,
          _isc.getType<_ilgienw1.RollDraft>,
          _isc.getType<_ikzltuid.Shot>,
          _isc.getType<_i0ulujow.ShotAck>,
          _isc.getType<_ibn1yndy.WallSnapshot>,
          _isc.getType<_i0jjlicg.WallActivity>,
          _isc.getType<_if8194bu.WallTick>,
          _isc.getType<_i04o2qcx.AlbumPhoto?>,
          _isc.getType<_i17f5dfe.DeliveryReport?>,
          _isc.getType<_iu57571s.Event?>,
          _isc.getType<_ilhd52bb.EventPublic?>,
          _isc.getType<_ih9iep0x.Guest?>,
          _isc.getType<_ig33w2mv.GuestDelivery?>,
          _isc.getType<_i2nfd3jx.HostEvent?>,
          _isc.getType<_irdkvnmr.JoinResult?>,
          _isc.getType<_iqidd2u5.JudgeSample?>,
          _isc.getType<_i7llcmuq.MehfilException?>,
          _isc.getType<_idi3lhss.PendingUpload?>,
          _isc.getType<_imh0m85v.PhotoCache?>,
          _isc.getType<_inreqcmk.RevealLog?>,
          _isc.getType<_iizodh34.Roll?>,
          _isc.getType<_i33oi965.RollCount?>,
          _isc.getType<_ilgienw1.RollDraft?>,
          _isc.getType<_ikzltuid.Shot?>,
          _isc.getType<_i0ulujow.ShotAck?>,
          _isc.getType<_ibn1yndy.WallSnapshot?>,
          _isc.getType<_i0jjlicg.WallActivity?>,
          _isc.getType<_if8194bu.WallTick?>,
          _isc.getType<List<_ig33w2mv.GuestDelivery>>,
          _isc.getType<List<String>>,
          _isc.getType<List<_iizodh34.Roll>>,
          _isc.getType<List<_i33oi965.RollCount>>,
          _isc.getType<List<_i0jjlicg.WallActivity>>,
          _isc.getType<List<_i4s7sdo1.RollDraft>>,
          _isc.getType<List<_icm8qwqy.HostEvent>>,
          _isc.getType<List<_ieq0999k.AlbumPhoto>>,
          _isc.getType<List<_irqmjged.RevealLog>>,
          _isc.getType<List<_isc.UuidValue>>,
        ],
        modules: const [
          _iaic.Protocol.new,
          _ipulbpi2.Protocol.new,
          _iacc.Protocol.new,
        ],
      );

  static List<_isd.TableDefinition> get targetTableDefinitions => [
    _isd.TableDefinition(
      name: 'album_photo',
      dartName: 'AlbumPhoto',
      schema: 'public',
      module: 'mehfil',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'spaceId',
          columnType: _isd.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isd.ColumnDefinition(
          name: 'shotId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'eventId',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'rollId',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'rollName',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'guestName',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'takenAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'receivedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'width',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'height',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _isd.ForeignKeyDefinition(
          constraintName: 'album_photo_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isd.ForeignKeyAction.noAction,
          onDelete: _isd.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isd.TableDefinition(
      name: 'pending_upload',
      dartName: 'PendingUpload',
      schema: 'public',
      module: 'mehfil',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isd.ColumnDefinition(
          name: 'shotId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'eventId',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'rollId',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'bytes',
          columnType: _isd.ColumnType.bytea,
          isNullable: false,
          dartType: 'dart:typed_data:ByteData',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'attempts',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isd.ColumnDefinition(
          name: 'lastError',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'pending_upload_shot_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'shotId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isd.TableDefinition(
      name: 'photo_cache',
      dartName: 'PhotoCache',
      schema: 'public',
      module: 'mehfil',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isd.ColumnDefinition(
          name: 'shotId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'thumb',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isd.ColumnDefinition(
          name: 'bytes',
          columnType: _isd.ColumnType.bytea,
          isNullable: false,
          dartType: 'dart:typed_data:ByteData',
        ),
        _isd.ColumnDefinition(
          name: 'savedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'photo_cache_shot_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'shotId',
            ),
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'thumb',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isd.TableDefinition(
      name: 'shot',
      dartName: 'Shot',
      schema: 'public',
      module: 'mehfil',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'spaceId',
          columnType: _isd.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isd.ColumnDefinition(
          name: 'eventId',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'rollId',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'guestName',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'takenAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'sha256',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'width',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'height',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'sizeBytes',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _isd.ForeignKeyDefinition(
          constraintName: 'shot_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isd.ForeignKeyAction.noAction,
          onDelete: _isd.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    ..._iaic.Protocol() is _isd.DatabaseSerializationManager
        ? (_iaic.Protocol() as _isd.DatabaseSerializationManager)
              .getTargetTableDefinitions()
        : [],
    ..._ipulbpi2.Protocol() is _isd.DatabaseSerializationManager
        ? (_ipulbpi2.Protocol() as _isd.DatabaseSerializationManager)
              .getTargetTableDefinitions()
        : [],
    ..._iacc.Protocol() is _isd.DatabaseSerializationManager
        ? (_iacc.Protocol() as _isd.DatabaseSerializationManager)
              .getTargetTableDefinitions()
        : [],
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i04o2qcx.AlbumPhoto) {
      return _i04o2qcx.AlbumPhoto.fromJson(data) as T;
    }
    if (t == _i17f5dfe.DeliveryReport) {
      return _i17f5dfe.DeliveryReport.fromJson(data) as T;
    }
    if (t == _iu57571s.Event) {
      return _iu57571s.Event.fromJson(data) as T;
    }
    if (t == _ilhd52bb.EventPublic) {
      return _ilhd52bb.EventPublic.fromJson(data) as T;
    }
    if (t == _ih9iep0x.Guest) {
      return _ih9iep0x.Guest.fromJson(data) as T;
    }
    if (t == _ig33w2mv.GuestDelivery) {
      return _ig33w2mv.GuestDelivery.fromJson(data) as T;
    }
    if (t == _i2nfd3jx.HostEvent) {
      return _i2nfd3jx.HostEvent.fromJson(data) as T;
    }
    if (t == _irdkvnmr.JoinResult) {
      return _irdkvnmr.JoinResult.fromJson(data) as T;
    }
    if (t == _iqidd2u5.JudgeSample) {
      return _iqidd2u5.JudgeSample.fromJson(data) as T;
    }
    if (t == _i7llcmuq.MehfilException) {
      return _i7llcmuq.MehfilException.fromJson(data) as T;
    }
    if (t == _idi3lhss.PendingUpload) {
      return _idi3lhss.PendingUpload.fromJson(data) as T;
    }
    if (t == _imh0m85v.PhotoCache) {
      return _imh0m85v.PhotoCache.fromJson(data) as T;
    }
    if (t == _inreqcmk.RevealLog) {
      return _inreqcmk.RevealLog.fromJson(data) as T;
    }
    if (t == _iizodh34.Roll) {
      return _iizodh34.Roll.fromJson(data) as T;
    }
    if (t == _i33oi965.RollCount) {
      return _i33oi965.RollCount.fromJson(data) as T;
    }
    if (t == _ilgienw1.RollDraft) {
      return _ilgienw1.RollDraft.fromJson(data) as T;
    }
    if (t == _ikzltuid.Shot) {
      return _ikzltuid.Shot.fromJson(data) as T;
    }
    if (t == _i0ulujow.ShotAck) {
      return _i0ulujow.ShotAck.fromJson(data) as T;
    }
    if (t == _ibn1yndy.WallSnapshot) {
      return _ibn1yndy.WallSnapshot.fromJson(data) as T;
    }
    if (t == _i0jjlicg.WallActivity) {
      return _i0jjlicg.WallActivity.fromJson(data) as T;
    }
    if (t == _if8194bu.WallTick) {
      return _if8194bu.WallTick.fromJson(data) as T;
    }
    if (t == _isc.getType<_i04o2qcx.AlbumPhoto?>()) {
      return (data != null ? _i04o2qcx.AlbumPhoto.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i17f5dfe.DeliveryReport?>()) {
      return (data != null ? _i17f5dfe.DeliveryReport.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iu57571s.Event?>()) {
      return (data != null ? _iu57571s.Event.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ilhd52bb.EventPublic?>()) {
      return (data != null ? _ilhd52bb.EventPublic.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ih9iep0x.Guest?>()) {
      return (data != null ? _ih9iep0x.Guest.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ig33w2mv.GuestDelivery?>()) {
      return (data != null ? _ig33w2mv.GuestDelivery.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i2nfd3jx.HostEvent?>()) {
      return (data != null ? _i2nfd3jx.HostEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irdkvnmr.JoinResult?>()) {
      return (data != null ? _irdkvnmr.JoinResult.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqidd2u5.JudgeSample?>()) {
      return (data != null ? _iqidd2u5.JudgeSample.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7llcmuq.MehfilException?>()) {
      return (data != null ? _i7llcmuq.MehfilException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_idi3lhss.PendingUpload?>()) {
      return (data != null ? _idi3lhss.PendingUpload.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_imh0m85v.PhotoCache?>()) {
      return (data != null ? _imh0m85v.PhotoCache.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inreqcmk.RevealLog?>()) {
      return (data != null ? _inreqcmk.RevealLog.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iizodh34.Roll?>()) {
      return (data != null ? _iizodh34.Roll.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i33oi965.RollCount?>()) {
      return (data != null ? _i33oi965.RollCount.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ilgienw1.RollDraft?>()) {
      return (data != null ? _ilgienw1.RollDraft.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ikzltuid.Shot?>()) {
      return (data != null ? _ikzltuid.Shot.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0ulujow.ShotAck?>()) {
      return (data != null ? _i0ulujow.ShotAck.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ibn1yndy.WallSnapshot?>()) {
      return (data != null ? _ibn1yndy.WallSnapshot.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0jjlicg.WallActivity?>()) {
      return (data != null ? _i0jjlicg.WallActivity.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_if8194bu.WallTick?>()) {
      return (data != null ? _if8194bu.WallTick.fromJson(data) : null) as T;
    }
    if (t == List<_ig33w2mv.GuestDelivery>) {
      return (data as List)
              .map((e) => deserialize<_ig33w2mv.GuestDelivery>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iizodh34.Roll>) {
      return (data as List).map((e) => deserialize<_iizodh34.Roll>(e)).toList()
          as T;
    }
    if (t == List<_i33oi965.RollCount>) {
      return (data as List)
              .map((e) => deserialize<_i33oi965.RollCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i0jjlicg.WallActivity>) {
      return (data as List)
              .map((e) => deserialize<_i0jjlicg.WallActivity>(e))
              .toList()
          as T;
    }
    if (t == List<_i4s7sdo1.RollDraft>) {
      return (data as List)
              .map((e) => deserialize<_i4s7sdo1.RollDraft>(e))
              .toList()
          as T;
    }
    if (t == List<_icm8qwqy.HostEvent>) {
      return (data as List)
              .map((e) => deserialize<_icm8qwqy.HostEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_ieq0999k.AlbumPhoto>) {
      return (data as List)
              .map((e) => deserialize<_ieq0999k.AlbumPhoto>(e))
              .toList()
          as T;
    }
    if (t == List<_irqmjged.RevealLog>) {
      return (data as List)
              .map((e) => deserialize<_irqmjged.RevealLog>(e))
              .toList()
          as T;
    }
    if (t == List<_isc.UuidValue>) {
      return (data as List).map((e) => deserialize<_isc.UuidValue>(e)).toList()
          as T;
    }
    final modules = dataClassName == null
        ? deserializationMetadata.modulesForType(t)
        : deserializationMetadata.modules;
    for (final module in modules) {
      try {
        return module.deserialize<T>(data, t);
      } on _isc.DeserializationTypeNotFoundException catch (_) {}
    }

    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i04o2qcx.AlbumPhoto => 'AlbumPhoto',
      _i17f5dfe.DeliveryReport => 'DeliveryReport',
      _iu57571s.Event => 'Event',
      _ilhd52bb.EventPublic => 'EventPublic',
      _ih9iep0x.Guest => 'Guest',
      _ig33w2mv.GuestDelivery => 'GuestDelivery',
      _i2nfd3jx.HostEvent => 'HostEvent',
      _irdkvnmr.JoinResult => 'JoinResult',
      _iqidd2u5.JudgeSample => 'JudgeSample',
      _i7llcmuq.MehfilException => 'MehfilException',
      _idi3lhss.PendingUpload => 'PendingUpload',
      _imh0m85v.PhotoCache => 'PhotoCache',
      _inreqcmk.RevealLog => 'RevealLog',
      _iizodh34.Roll => 'Roll',
      _i33oi965.RollCount => 'RollCount',
      _ilgienw1.RollDraft => 'RollDraft',
      _ikzltuid.Shot => 'Shot',
      _i0ulujow.ShotAck => 'ShotAck',
      _ibn1yndy.WallSnapshot => 'WallSnapshot',
      _i0jjlicg.WallActivity => 'WallActivity',
      _if8194bu.WallTick => 'WallTick',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('mehfil.', '');
    }

    switch (data) {
      case _i04o2qcx.AlbumPhoto():
        return 'AlbumPhoto';
      case _i17f5dfe.DeliveryReport():
        return 'DeliveryReport';
      case _iu57571s.Event():
        return 'Event';
      case _ilhd52bb.EventPublic():
        return 'EventPublic';
      case _ih9iep0x.Guest():
        return 'Guest';
      case _ig33w2mv.GuestDelivery():
        return 'GuestDelivery';
      case _i2nfd3jx.HostEvent():
        return 'HostEvent';
      case _irdkvnmr.JoinResult():
        return 'JoinResult';
      case _iqidd2u5.JudgeSample():
        return 'JudgeSample';
      case _i7llcmuq.MehfilException():
        return 'MehfilException';
      case _idi3lhss.PendingUpload():
        return 'PendingUpload';
      case _imh0m85v.PhotoCache():
        return 'PhotoCache';
      case _inreqcmk.RevealLog():
        return 'RevealLog';
      case _iizodh34.Roll():
        return 'Roll';
      case _i33oi965.RollCount():
        return 'RollCount';
      case _ilgienw1.RollDraft():
        return 'RollDraft';
      case _ikzltuid.Shot():
        return 'Shot';
      case _i0ulujow.ShotAck():
        return 'ShotAck';
      case _ibn1yndy.WallSnapshot():
        return 'WallSnapshot';
      case _i0jjlicg.WallActivity():
        return 'WallActivity';
      case _if8194bu.WallTick():
        return 'WallTick';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _ipulbpi2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_offline_sync.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AlbumPhoto') {
      return deserialize<_i04o2qcx.AlbumPhoto>(data['data']);
    }
    if (dataClassName == 'DeliveryReport') {
      return deserialize<_i17f5dfe.DeliveryReport>(data['data']);
    }
    if (dataClassName == 'Event') {
      return deserialize<_iu57571s.Event>(data['data']);
    }
    if (dataClassName == 'EventPublic') {
      return deserialize<_ilhd52bb.EventPublic>(data['data']);
    }
    if (dataClassName == 'Guest') {
      return deserialize<_ih9iep0x.Guest>(data['data']);
    }
    if (dataClassName == 'GuestDelivery') {
      return deserialize<_ig33w2mv.GuestDelivery>(data['data']);
    }
    if (dataClassName == 'HostEvent') {
      return deserialize<_i2nfd3jx.HostEvent>(data['data']);
    }
    if (dataClassName == 'JoinResult') {
      return deserialize<_irdkvnmr.JoinResult>(data['data']);
    }
    if (dataClassName == 'JudgeSample') {
      return deserialize<_iqidd2u5.JudgeSample>(data['data']);
    }
    if (dataClassName == 'MehfilException') {
      return deserialize<_i7llcmuq.MehfilException>(data['data']);
    }
    if (dataClassName == 'PendingUpload') {
      return deserialize<_idi3lhss.PendingUpload>(data['data']);
    }
    if (dataClassName == 'PhotoCache') {
      return deserialize<_imh0m85v.PhotoCache>(data['data']);
    }
    if (dataClassName == 'RevealLog') {
      return deserialize<_inreqcmk.RevealLog>(data['data']);
    }
    if (dataClassName == 'Roll') {
      return deserialize<_iizodh34.Roll>(data['data']);
    }
    if (dataClassName == 'RollCount') {
      return deserialize<_i33oi965.RollCount>(data['data']);
    }
    if (dataClassName == 'RollDraft') {
      return deserialize<_ilgienw1.RollDraft>(data['data']);
    }
    if (dataClassName == 'Shot') {
      return deserialize<_ikzltuid.Shot>(data['data']);
    }
    if (dataClassName == 'ShotAck') {
      return deserialize<_i0ulujow.ShotAck>(data['data']);
    }
    if (dataClassName == 'WallSnapshot') {
      return deserialize<_ibn1yndy.WallSnapshot>(data['data']);
    }
    if (dataClassName == 'WallActivity') {
      return deserialize<_i0jjlicg.WallActivity>(data['data']);
    }
    if (dataClassName == 'WallTick') {
      return deserialize<_if8194bu.WallTick>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_offline_sync.')) {
      data['className'] = dataClassName.substring(23);
      return _ipulbpi2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('mehfil', this);
    _ipulbpi2.Protocol().registerHostProtocol('mehfil', this);
    _iacc.Protocol().registerHostProtocol('mehfil', this);
  }

  @override
  _isd.Table? getTableForType(Type t) {
    {
      var protocol = _iaic.Protocol();
      var table = protocol is _isd.DatabaseSerializationManager
          ? (protocol as _isd.DatabaseSerializationManager).getTableForType(t)
          : null;
      if (table != null) {
        return table;
      }
    }
    {
      var protocol = _ipulbpi2.Protocol();
      var table = protocol is _isd.DatabaseSerializationManager
          ? (protocol as _isd.DatabaseSerializationManager).getTableForType(t)
          : null;
      if (table != null) {
        return table;
      }
    }
    {
      var protocol = _iacc.Protocol();
      var table = protocol is _isd.DatabaseSerializationManager
          ? (protocol as _isd.DatabaseSerializationManager).getTableForType(t)
          : null;
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i04o2qcx.AlbumPhoto:
        return _i04o2qcx.AlbumPhoto.t;
      case _idi3lhss.PendingUpload:
        return _idi3lhss.PendingUpload.t;
      case _imh0m85v.PhotoCache:
        return _imh0m85v.PhotoCache.t;
      case _ikzltuid.Shot:
        return _ikzltuid.Shot.t;
    }
    return null;
  }

  @override
  List<_isd.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'mehfil';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _ipulbpi2.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
