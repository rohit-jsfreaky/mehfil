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
import 'dart:async' as _ida;
import 'package:serverpod/serverpod.dart' as _is;

/// A revealed photo. The reveal writes these into the event's album space, and
/// offline sync carries them to every guest's phone.
abstract class AlbumPhoto
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  AlbumPhoto._({
    this.id,
    this.spaceId,
    required this.shotId,
    required this.eventId,
    required this.rollId,
    required this.rollName,
    required this.guestName,
    required this.takenAt,
    required this.receivedAt,
    required this.width,
    required this.height,
  });

  factory AlbumPhoto({
    _is.UuidValue? id,
    int? spaceId,
    required _is.UuidValue shotId,
    required int eventId,
    required int rollId,
    required String rollName,
    required String guestName,
    required DateTime takenAt,
    required DateTime receivedAt,
    required int width,
    required int height,
  }) = _AlbumPhotoImpl;

  factory AlbumPhoto.fromJson(Map<String, dynamic> jsonSerialization) {
    return AlbumPhoto(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      spaceId: jsonSerialization['spaceId'] as int?,
      shotId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['shotId']),
      eventId: jsonSerialization['eventId'] as int,
      rollId: jsonSerialization['rollId'] as int,
      rollName: jsonSerialization['rollName'] as String,
      guestName: jsonSerialization['guestName'] as String,
      takenAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['takenAt']),
      receivedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
      width: jsonSerialization['width'] as int,
      height: jsonSerialization['height'] as int,
    );
  }

  static final t = AlbumPhotoTable();

  static const db = AlbumPhotoRepository._();

  @override
  _is.UuidValue? id;

  /// The space owning this row. Maintained by the sync engine.
  int? spaceId;

  _is.UuidValue shotId;

  int eventId;

  int rollId;

  String rollName;

  String guestName;

  DateTime takenAt;

  DateTime receivedAt;

  int width;

  int height;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [AlbumPhoto]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AlbumPhoto copyWith({
    _is.UuidValue? id = const _is.$UndefinedUuidValue(),
    int? spaceId,
    _is.UuidValue? shotId,
    int? eventId,
    int? rollId,
    String? rollName,
    String? guestName,
    DateTime? takenAt,
    DateTime? receivedAt,
    int? width,
    int? height,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AlbumPhoto',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'shotId': shotId.toJson(),
      'eventId': eventId,
      'rollId': rollId,
      'rollName': rollName,
      'guestName': guestName,
      'takenAt': takenAt.toJson(),
      'receivedAt': receivedAt.toJson(),
      'width': width,
      'height': height,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AlbumPhoto',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'shotId': shotId.toJson(),
      'eventId': eventId,
      'rollId': rollId,
      'rollName': rollName,
      'guestName': guestName,
      'takenAt': takenAt.toJson(),
      'receivedAt': receivedAt.toJson(),
      'width': width,
      'height': height,
    };
  }

  static AlbumPhotoInclude include() {
    return AlbumPhotoInclude._();
  }

  static AlbumPhotoIncludeList includeList({
    _is.WhereExpressionBuilder<AlbumPhotoTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AlbumPhotoTable>? orderBy,
    _is.OrderByListBuilder<AlbumPhotoTable>? orderByList,
    AlbumPhotoInclude? include,
  }) {
    return AlbumPhotoIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AlbumPhoto.t),
      orderByList: orderByList?.call(AlbumPhoto.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AlbumPhotoImpl extends AlbumPhoto {
  _AlbumPhotoImpl({
    _is.UuidValue? id,
    int? spaceId,
    required _is.UuidValue shotId,
    required int eventId,
    required int rollId,
    required String rollName,
    required String guestName,
    required DateTime takenAt,
    required DateTime receivedAt,
    required int width,
    required int height,
  }) : super._(
         id: id,
         spaceId: spaceId,
         shotId: shotId,
         eventId: eventId,
         rollId: rollId,
         rollName: rollName,
         guestName: guestName,
         takenAt: takenAt,
         receivedAt: receivedAt,
         width: width,
         height: height,
       );

  /// Returns a shallow copy of this [AlbumPhoto]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AlbumPhoto copyWith({
    _is.UuidValue? id = const _is.$UndefinedUuidValue(),
    Object? spaceId = _Undefined,
    _is.UuidValue? shotId,
    int? eventId,
    int? rollId,
    String? rollName,
    String? guestName,
    DateTime? takenAt,
    DateTime? receivedAt,
    int? width,
    int? height,
  }) {
    return AlbumPhoto(
      id: id is _is.UndefinedSentinel ? this.id : id,
      spaceId: spaceId is int? ? spaceId : this.spaceId,
      shotId: shotId ?? this.shotId,
      eventId: eventId ?? this.eventId,
      rollId: rollId ?? this.rollId,
      rollName: rollName ?? this.rollName,
      guestName: guestName ?? this.guestName,
      takenAt: takenAt ?? this.takenAt,
      receivedAt: receivedAt ?? this.receivedAt,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}

class AlbumPhotoUpdateTable extends _is.UpdateTable<AlbumPhotoTable> {
  AlbumPhotoUpdateTable(super.table);

  _is.ColumnValue<int, int> spaceId(int? value) => _is.ColumnValue(
    table.spaceId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> shotId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.shotId,
        value,
      );

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<int, int> rollId(int value) => _is.ColumnValue(
    table.rollId,
    value,
  );

  _is.ColumnValue<String, String> rollName(String value) => _is.ColumnValue(
    table.rollName,
    value,
  );

  _is.ColumnValue<String, String> guestName(String value) => _is.ColumnValue(
    table.guestName,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> takenAt(DateTime value) =>
      _is.ColumnValue(
        table.takenAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> receivedAt(DateTime value) =>
      _is.ColumnValue(
        table.receivedAt,
        value,
      );

  _is.ColumnValue<int, int> width(int value) => _is.ColumnValue(
    table.width,
    value,
  );

  _is.ColumnValue<int, int> height(int value) => _is.ColumnValue(
    table.height,
    value,
  );
}

class AlbumPhotoTable extends _is.Table<_is.UuidValue?> {
  AlbumPhotoTable({super.tableRelation}) : super(tableName: 'album_photo') {
    updateTable = AlbumPhotoUpdateTable(this);
    spaceId = _is.ColumnInt(
      'spaceId',
      this,
    );
    shotId = _is.ColumnUuid(
      'shotId',
      this,
    );
    eventId = _is.ColumnInt(
      'eventId',
      this,
    );
    rollId = _is.ColumnInt(
      'rollId',
      this,
    );
    rollName = _is.ColumnString(
      'rollName',
      this,
    );
    guestName = _is.ColumnString(
      'guestName',
      this,
    );
    takenAt = _is.ColumnDateTime(
      'takenAt',
      this,
    );
    receivedAt = _is.ColumnDateTime(
      'receivedAt',
      this,
    );
    width = _is.ColumnInt(
      'width',
      this,
    );
    height = _is.ColumnInt(
      'height',
      this,
    );
  }

  late final AlbumPhotoUpdateTable updateTable;

  /// The space owning this row. Maintained by the sync engine.
  late final _is.ColumnInt spaceId;

  late final _is.ColumnUuid shotId;

  late final _is.ColumnInt eventId;

  late final _is.ColumnInt rollId;

  late final _is.ColumnString rollName;

  late final _is.ColumnString guestName;

  late final _is.ColumnDateTime takenAt;

  late final _is.ColumnDateTime receivedAt;

  late final _is.ColumnInt width;

  late final _is.ColumnInt height;

  @override
  List<_is.Column> get columns => [
    id,
    spaceId,
    shotId,
    eventId,
    rollId,
    rollName,
    guestName,
    takenAt,
    receivedAt,
    width,
    height,
  ];
}

class AlbumPhotoInclude extends _is.IncludeObject {
  AlbumPhotoInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => AlbumPhoto.t;
}

class AlbumPhotoIncludeList extends _is.IncludeList {
  AlbumPhotoIncludeList._({
    _is.WhereExpressionBuilder<AlbumPhotoTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AlbumPhoto.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => AlbumPhoto.t;
}

class AlbumPhotoRepository {
  const AlbumPhotoRepository._();

  /// Returns a list of [AlbumPhoto]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<AlbumPhoto>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AlbumPhotoTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AlbumPhotoTable>? orderBy,
    _is.OrderByListBuilder<AlbumPhotoTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AlbumPhoto>(
      where: where?.call(AlbumPhoto.t),
      orderBy: orderBy?.call(AlbumPhoto.t),
      orderByList: orderByList?.call(AlbumPhoto.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [AlbumPhoto]s matching the given query parameters every time the
  /// source tables are modified.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// Use [throttle] to specify the minimum interval between queries. It can
  /// also be set to `null`, in which case the stream will only be throttled
  /// when its subscription is paused.
  ///
  /// Source tables are collected from the queried table, [where], [orderBy],
  /// [orderByList], and the [include] graph. [alsoTriggerOnTables] is added
  /// to that set. Pass [Table] instances such as `AlbumPhoto.t`.
  ///
  /// Raw [Expression] SQL is not inspected. Tables referenced only in raw
  /// SQL must be passed via [alsoTriggerOnTables].
  ///
  /// The stream always reads committed state and never joins an ambient
  /// [Transaction]. Emissions for a write fire after that write commits.
  ///
  /// Currently only supported on SQLite. Calling this method on PostgreSQL
  /// throws an [UnsupportedError].
  ///
  /// ```dart
  /// var subscription = Persons.db.watch(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// ).listen((persons) {
  ///   // Handle the latest matching rows.
  /// });
  /// ```
  _ida.Stream<List<AlbumPhoto>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AlbumPhotoTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AlbumPhotoTable>? orderBy,
    _is.OrderByListBuilder<AlbumPhotoTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<AlbumPhoto>(
      where: where?.call(AlbumPhoto.t),
      orderBy: orderBy?.call(AlbumPhoto.t),
      orderByList: orderByList?.call(AlbumPhoto.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [AlbumPhoto] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<AlbumPhoto?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AlbumPhotoTable>? where,
    int? offset,
    _is.OrderByBuilder<AlbumPhotoTable>? orderBy,
    _is.OrderByListBuilder<AlbumPhotoTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AlbumPhoto>(
      where: where?.call(AlbumPhoto.t),
      orderBy: orderBy?.call(AlbumPhoto.t),
      orderByList: orderByList?.call(AlbumPhoto.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AlbumPhoto] by its [id] or null if no such row exists.
  Future<AlbumPhoto?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AlbumPhoto>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AlbumPhoto]s in the list and returns the inserted rows.
  ///
  /// The returned [AlbumPhoto]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AlbumPhoto>> insert(
    _is.DatabaseSession session,
    List<AlbumPhoto> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AlbumPhoto>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AlbumPhoto] and returns the inserted row.
  ///
  /// The returned [AlbumPhoto] will have its `id` field set.
  Future<AlbumPhoto> insertRow(
    _is.DatabaseSession session,
    AlbumPhoto row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AlbumPhoto>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AlbumPhoto]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [AlbumPhoto]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AlbumPhoto>> upsert(
    _is.DatabaseSession session,
    List<AlbumPhoto> rows, {
    required _is.ColumnSelections<AlbumPhotoTable> conflictColumns,
    _is.ColumnSelections<AlbumPhotoTable>? updateColumns,
    _is.WhereExpressionBuilder<AlbumPhotoTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AlbumPhoto>(
      rows,
      conflictColumns: conflictColumns(AlbumPhoto.t),
      updateColumns: updateColumns?.call(AlbumPhoto.t),
      updateWhere: updateWhere?.call(AlbumPhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AlbumPhoto] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [AlbumPhoto] will have its `id` field set.
  Future<AlbumPhoto?> upsertRow(
    _is.DatabaseSession session,
    AlbumPhoto row, {
    required _is.ColumnSelections<AlbumPhotoTable> conflictColumns,
    _is.ColumnSelections<AlbumPhotoTable>? updateColumns,
    _is.WhereExpressionBuilder<AlbumPhotoTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AlbumPhoto>(
      row,
      conflictColumns: conflictColumns(AlbumPhoto.t),
      updateColumns: updateColumns?.call(AlbumPhoto.t),
      updateWhere: updateWhere?.call(AlbumPhoto.t),
      transaction: transaction,
    );
  }

  /// Updates all [AlbumPhoto]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AlbumPhoto>> update(
    _is.DatabaseSession session,
    List<AlbumPhoto> rows, {
    _is.ColumnSelections<AlbumPhotoTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AlbumPhoto>(
      rows,
      columns: columns?.call(AlbumPhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AlbumPhoto]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AlbumPhoto> updateRow(
    _is.DatabaseSession session,
    AlbumPhoto row, {
    _is.ColumnSelections<AlbumPhotoTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AlbumPhoto>(
      row,
      columns: columns?.call(AlbumPhoto.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AlbumPhoto] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AlbumPhoto?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<AlbumPhotoUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AlbumPhoto>(
      id,
      columnValues: columnValues(AlbumPhoto.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AlbumPhoto]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AlbumPhoto>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AlbumPhotoUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AlbumPhotoTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AlbumPhotoTable>? orderBy,
    _is.OrderByListBuilder<AlbumPhotoTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AlbumPhoto>(
      columnValues: columnValues(AlbumPhoto.t.updateTable),
      where: where(AlbumPhoto.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AlbumPhoto.t),
      orderByList: orderByList?.call(AlbumPhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AlbumPhoto]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AlbumPhoto>> delete(
    _is.DatabaseSession session,
    List<AlbumPhoto> rows, {
    _is.OrderByBuilder<AlbumPhotoTable>? orderBy,
    _is.OrderByListBuilder<AlbumPhotoTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AlbumPhoto>(
      rows,
      orderBy: orderBy?.call(AlbumPhoto.t),
      orderByList: orderByList?.call(AlbumPhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AlbumPhoto].
  Future<AlbumPhoto> deleteRow(
    _is.DatabaseSession session,
    AlbumPhoto row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AlbumPhoto>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AlbumPhoto>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AlbumPhotoTable> where,
    _is.OrderByBuilder<AlbumPhotoTable>? orderBy,
    _is.OrderByListBuilder<AlbumPhotoTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AlbumPhoto>(
      where: where(AlbumPhoto.t),
      orderBy: orderBy?.call(AlbumPhoto.t),
      orderByList: orderByList?.call(AlbumPhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AlbumPhotoTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AlbumPhoto>(
      where: where?.call(AlbumPhoto.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AlbumPhoto] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AlbumPhotoTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AlbumPhoto>(
      where: where(AlbumPhoto.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
