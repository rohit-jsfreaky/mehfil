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
import 'package:mehfil_server/src/generated/album_photo.dart' as _idryo2e1;
import 'package:mehfil_server/src/generated/host_event.dart' as _iv5g6lcq;
import 'package:mehfil_server/src/generated/reveal_log.dart' as _ivsu041u;
import 'package:mehfil_server/src/generated/roll_draft.dart' as _i5yo6dyh;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:serverpod_offline_sync_server/serverpod_offline_sync_server.dart'
    as _izehhkf5;
import 'album_photo.dart' as _i04o2qcx;
import 'delivery_report.dart' as _i17f5dfe;
import 'event.dart' as _iu57571s;
import 'event_public.dart' as _ilhd52bb;
import 'future_calls_generated_models/reveal_future_call_open_roll_model.dart'
    as _i8tjmnzq;
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
import 'shot_receipt.dart' as _i2t6km4z;
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
export 'shot_receipt.dart';
export 'wall.dart';
export 'wall_activity.dart';
export 'wall_tick.dart';
export 'sync_tables.dart';

class Protocol extends _is.DatabaseSerializationManager
    implements _is.DatabaseProtocolDeserializationProvider {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  @override
  _is.ProtocolDeserialization get deserializationMetadata =>
      _is.ProtocolDeserialization.cached(
        this,
        types: const [
          _is.getType<_i04o2qcx.AlbumPhoto>,
          _is.getType<_i17f5dfe.DeliveryReport>,
          _is.getType<_iu57571s.Event>,
          _is.getType<_ilhd52bb.EventPublic>,
          _is.getType<_i8tjmnzq.RevealFutureCallOpenRollModel>,
          _is.getType<_ih9iep0x.Guest>,
          _is.getType<_ig33w2mv.GuestDelivery>,
          _is.getType<_i2nfd3jx.HostEvent>,
          _is.getType<_irdkvnmr.JoinResult>,
          _is.getType<_iqidd2u5.JudgeSample>,
          _is.getType<_i7llcmuq.MehfilException>,
          _is.getType<_idi3lhss.PendingUpload>,
          _is.getType<_imh0m85v.PhotoCache>,
          _is.getType<_inreqcmk.RevealLog>,
          _is.getType<_iizodh34.Roll>,
          _is.getType<_i33oi965.RollCount>,
          _is.getType<_ilgienw1.RollDraft>,
          _is.getType<_ikzltuid.Shot>,
          _is.getType<_i0ulujow.ShotAck>,
          _is.getType<_i2t6km4z.ShotReceipt>,
          _is.getType<_ibn1yndy.WallSnapshot>,
          _is.getType<_i0jjlicg.WallActivity>,
          _is.getType<_if8194bu.WallTick>,
          _is.getType<_i04o2qcx.AlbumPhoto?>,
          _is.getType<_i17f5dfe.DeliveryReport?>,
          _is.getType<_iu57571s.Event?>,
          _is.getType<_ilhd52bb.EventPublic?>,
          _is.getType<_i8tjmnzq.RevealFutureCallOpenRollModel?>,
          _is.getType<_ih9iep0x.Guest?>,
          _is.getType<_ig33w2mv.GuestDelivery?>,
          _is.getType<_i2nfd3jx.HostEvent?>,
          _is.getType<_irdkvnmr.JoinResult?>,
          _is.getType<_iqidd2u5.JudgeSample?>,
          _is.getType<_i7llcmuq.MehfilException?>,
          _is.getType<_idi3lhss.PendingUpload?>,
          _is.getType<_imh0m85v.PhotoCache?>,
          _is.getType<_inreqcmk.RevealLog?>,
          _is.getType<_iizodh34.Roll?>,
          _is.getType<_i33oi965.RollCount?>,
          _is.getType<_ilgienw1.RollDraft?>,
          _is.getType<_ikzltuid.Shot?>,
          _is.getType<_i0ulujow.ShotAck?>,
          _is.getType<_i2t6km4z.ShotReceipt?>,
          _is.getType<_ibn1yndy.WallSnapshot?>,
          _is.getType<_i0jjlicg.WallActivity?>,
          _is.getType<_if8194bu.WallTick?>,
          _is.getType<List<_ig33w2mv.GuestDelivery>>,
          _is.getType<List<String>>,
          _is.getType<List<_iizodh34.Roll>>,
          _is.getType<List<_i33oi965.RollCount>>,
          _is.getType<List<_i0jjlicg.WallActivity>>,
          _is.getType<List<_i5yo6dyh.RollDraft>>,
          _is.getType<List<_iv5g6lcq.HostEvent>>,
          _is.getType<List<_idryo2e1.AlbumPhoto>>,
          _is.getType<List<_ivsu041u.RevealLog>>,
          _is.getType<List<_is.UuidValue>>,
        ],
        modules: const [
          _iais.Protocol.new,
          _izehhkf5.Protocol.new,
          _iacs.Protocol.new,
          _isp.Protocol.new,
        ],
      );

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'album_photo',
      dartName: 'AlbumPhoto',
      schema: 'public',
      module: 'mehfil',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'spaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'shotId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'rollId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'rollName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'guestName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'takenAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'receivedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'width',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'height',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'album_photo_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'event',
      dartName: 'Event',
      schema: 'public',
      module: 'mehfil',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'hostedBy',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'joinCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'hostUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'albumSpaceId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'isDemo',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'event_join_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'joinCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'guest',
      dartName: 'Guest',
      schema: 'public',
      module: 'mehfil',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'recoveryHash',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'guest_fk_0',
          columns: ['eventId'],
          referenceTable: 'event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'guest_event_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'reveal_log',
      dartName: 'RevealLog',
      schema: 'public',
      module: 'mehfil',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'rollId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'trigger',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'photos',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'revealedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'reveal_log_fk_0',
          columns: ['rollId'],
          referenceTable: 'roll',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'reveal_log_roll_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'rollId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'roll',
      dartName: 'Roll',
      schema: 'public',
      module: 'mehfil',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sortOrder',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'revealAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'revealedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'shotsPerGuest',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '27',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'roll_fk_0',
          columns: ['eventId'],
          referenceTable: 'event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'roll_event_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'shot',
      dartName: 'Shot',
      schema: 'public',
      module: 'mehfil',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'spaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'rollId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'guestName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'takenAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'sha256',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'width',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'height',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'sizeBytes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'shot_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'shot_receipt',
      dartName: 'ShotReceipt',
      schema: 'public',
      module: 'mehfil',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'shotId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'rollId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'guestId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'storagePath',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'thumbPath',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sha256',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sizeBytes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'width',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'height',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'takenAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'receivedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'removedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'shot_receipt_fk_0',
          columns: ['eventId'],
          referenceTable: 'event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'shot_receipt_fk_1',
          columns: ['rollId'],
          referenceTable: 'roll',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'shot_receipt_fk_2',
          columns: ['guestId'],
          referenceTable: 'guest',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'shot_receipt_shot_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'shotId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'shot_receipt_roll_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'rollId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._izehhkf5.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _i8tjmnzq.RevealFutureCallOpenRollModel) {
      return _i8tjmnzq.RevealFutureCallOpenRollModel.fromJson(data) as T;
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
    if (t == _i2t6km4z.ShotReceipt) {
      return _i2t6km4z.ShotReceipt.fromJson(data) as T;
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
    if (t == _is.getType<_i04o2qcx.AlbumPhoto?>()) {
      return (data != null ? _i04o2qcx.AlbumPhoto.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i17f5dfe.DeliveryReport?>()) {
      return (data != null ? _i17f5dfe.DeliveryReport.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iu57571s.Event?>()) {
      return (data != null ? _iu57571s.Event.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ilhd52bb.EventPublic?>()) {
      return (data != null ? _ilhd52bb.EventPublic.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8tjmnzq.RevealFutureCallOpenRollModel?>()) {
      return (data != null
              ? _i8tjmnzq.RevealFutureCallOpenRollModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ih9iep0x.Guest?>()) {
      return (data != null ? _ih9iep0x.Guest.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ig33w2mv.GuestDelivery?>()) {
      return (data != null ? _ig33w2mv.GuestDelivery.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i2nfd3jx.HostEvent?>()) {
      return (data != null ? _i2nfd3jx.HostEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irdkvnmr.JoinResult?>()) {
      return (data != null ? _irdkvnmr.JoinResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iqidd2u5.JudgeSample?>()) {
      return (data != null ? _iqidd2u5.JudgeSample.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7llcmuq.MehfilException?>()) {
      return (data != null ? _i7llcmuq.MehfilException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_idi3lhss.PendingUpload?>()) {
      return (data != null ? _idi3lhss.PendingUpload.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_imh0m85v.PhotoCache?>()) {
      return (data != null ? _imh0m85v.PhotoCache.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_inreqcmk.RevealLog?>()) {
      return (data != null ? _inreqcmk.RevealLog.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iizodh34.Roll?>()) {
      return (data != null ? _iizodh34.Roll.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i33oi965.RollCount?>()) {
      return (data != null ? _i33oi965.RollCount.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ilgienw1.RollDraft?>()) {
      return (data != null ? _ilgienw1.RollDraft.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikzltuid.Shot?>()) {
      return (data != null ? _ikzltuid.Shot.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i0ulujow.ShotAck?>()) {
      return (data != null ? _i0ulujow.ShotAck.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i2t6km4z.ShotReceipt?>()) {
      return (data != null ? _i2t6km4z.ShotReceipt.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ibn1yndy.WallSnapshot?>()) {
      return (data != null ? _ibn1yndy.WallSnapshot.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i0jjlicg.WallActivity?>()) {
      return (data != null ? _i0jjlicg.WallActivity.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_if8194bu.WallTick?>()) {
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
    if (t == List<_i5yo6dyh.RollDraft>) {
      return (data as List)
              .map((e) => deserialize<_i5yo6dyh.RollDraft>(e))
              .toList()
          as T;
    }
    if (t == List<_iv5g6lcq.HostEvent>) {
      return (data as List)
              .map((e) => deserialize<_iv5g6lcq.HostEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_idryo2e1.AlbumPhoto>) {
      return (data as List)
              .map((e) => deserialize<_idryo2e1.AlbumPhoto>(e))
              .toList()
          as T;
    }
    if (t == List<_ivsu041u.RevealLog>) {
      return (data as List)
              .map((e) => deserialize<_ivsu041u.RevealLog>(e))
              .toList()
          as T;
    }
    if (t == List<_is.UuidValue>) {
      return (data as List).map((e) => deserialize<_is.UuidValue>(e)).toList()
          as T;
    }
    final modules = dataClassName == null
        ? deserializationMetadata.modulesForType(t)
        : deserializationMetadata.modules;
    for (final module in modules) {
      try {
        return module.deserialize<T>(data, t);
      } on _is.DeserializationTypeNotFoundException catch (_) {}
    }

    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i04o2qcx.AlbumPhoto => 'AlbumPhoto',
      _i17f5dfe.DeliveryReport => 'DeliveryReport',
      _iu57571s.Event => 'Event',
      _ilhd52bb.EventPublic => 'EventPublic',
      _i8tjmnzq.RevealFutureCallOpenRollModel =>
        'RevealFutureCallOpenRollModel',
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
      _i2t6km4z.ShotReceipt => 'ShotReceipt',
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
      case _i8tjmnzq.RevealFutureCallOpenRollModel():
        return 'RevealFutureCallOpenRollModel';
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
      case _i2t6km4z.ShotReceipt():
        return 'ShotReceipt';
      case _ibn1yndy.WallSnapshot():
        return 'WallSnapshot';
      case _i0jjlicg.WallActivity():
        return 'WallActivity';
      case _if8194bu.WallTick():
        return 'WallTick';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _izehhkf5.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_offline_sync.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
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
    if (dataClassName == 'RevealFutureCallOpenRollModel') {
      return deserialize<_i8tjmnzq.RevealFutureCallOpenRollModel>(data['data']);
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
    if (dataClassName == 'ShotReceipt') {
      return deserialize<_i2t6km4z.ShotReceipt>(data['data']);
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
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_offline_sync.')) {
      data['className'] = dataClassName.substring(23);
      return _izehhkf5.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('mehfil', this);
    _izehhkf5.Protocol().registerHostProtocol('mehfil', this);
    _iacs.Protocol().registerHostProtocol('mehfil', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _izehhkf5.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i04o2qcx.AlbumPhoto:
        return _i04o2qcx.AlbumPhoto.t;
      case _iu57571s.Event:
        return _iu57571s.Event.t;
      case _ih9iep0x.Guest:
        return _ih9iep0x.Guest.t;
      case _inreqcmk.RevealLog:
        return _inreqcmk.RevealLog.t;
      case _iizodh34.Roll:
        return _iizodh34.Roll.t;
      case _ikzltuid.Shot:
        return _ikzltuid.Shot.t;
      case _i2t6km4z.ShotReceipt:
        return _i2t6km4z.ShotReceipt.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
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
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _izehhkf5.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
