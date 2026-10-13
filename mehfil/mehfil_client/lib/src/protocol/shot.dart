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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;

/// A photo a guest took. Written on the phone first (even with no signal) in
/// the guest's personal sync space, so nobody else can see it.
abstract class Shot
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  Shot._({
    this.id,
    this.spaceId,
    required this.eventId,
    required this.rollId,
    required this.guestName,
    required this.takenAt,
    required this.sha256,
    required this.width,
    required this.height,
    required this.sizeBytes,
  });

  factory Shot({
    _isc.UuidValue? id,
    int? spaceId,
    required int eventId,
    required int rollId,
    required String guestName,
    required DateTime takenAt,
    required String sha256,
    required int width,
    required int height,
    required int sizeBytes,
  }) = _ShotImpl;

  factory Shot.fromJson(Map<String, dynamic> jsonSerialization) {
    return Shot(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      spaceId: jsonSerialization['spaceId'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      rollId: jsonSerialization['rollId'] as int,
      guestName: jsonSerialization['guestName'] as String,
      takenAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['takenAt'],
      ),
      sha256: jsonSerialization['sha256'] as String,
      width: jsonSerialization['width'] as int,
      height: jsonSerialization['height'] as int,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
    );
  }

  static final t = ShotTable();

  static const db = ShotRepository._();

  @override
  _isc.UuidValue? id;

  /// The space owning this row. Maintained by the sync engine.
  int? spaceId;

  int eventId;

  int rollId;

  String guestName;

  /// The phone's clock when the shutter was pressed. A claim, not a fact.
  DateTime takenAt;

  String sha256;

  int width;

  int height;

  int sizeBytes;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Shot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Shot copyWith({
    _isc.UuidValue? id = const _isc.$UndefinedUuidValue(),
    int? spaceId,
    int? eventId,
    int? rollId,
    String? guestName,
    DateTime? takenAt,
    String? sha256,
    int? width,
    int? height,
    int? sizeBytes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Shot',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'eventId': eventId,
      'rollId': rollId,
      'guestName': guestName,
      'takenAt': takenAt.toJson(),
      'sha256': sha256,
      'width': width,
      'height': height,
      'sizeBytes': sizeBytes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Shot',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'eventId': eventId,
      'rollId': rollId,
      'guestName': guestName,
      'takenAt': takenAt.toJson(),
      'sha256': sha256,
      'width': width,
      'height': height,
      'sizeBytes': sizeBytes,
    };
  }

  static ShotInclude include() {
    return ShotInclude._();
  }

  static ShotIncludeList includeList({
    _isd.WhereExpressionBuilder<ShotTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<ShotTable>? orderBy,
    _isd.OrderByListBuilder<ShotTable>? orderByList,
    ShotInclude? include,
  }) {
    return ShotIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Shot.t),
      orderByList: orderByList?.call(Shot.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShotImpl extends Shot {
  _ShotImpl({
    _isc.UuidValue? id,
    int? spaceId,
    required int eventId,
    required int rollId,
    required String guestName,
    required DateTime takenAt,
    required String sha256,
    required int width,
    required int height,
    required int sizeBytes,
  }) : super._(
         id: id,
         spaceId: spaceId,
         eventId: eventId,
         rollId: rollId,
         guestName: guestName,
         takenAt: takenAt,
         sha256: sha256,
         width: width,
         height: height,
         sizeBytes: sizeBytes,
       );

  /// Returns a shallow copy of this [Shot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Shot copyWith({
    _isc.UuidValue? id = const _isc.$UndefinedUuidValue(),
    Object? spaceId = _Undefined,
    int? eventId,
    int? rollId,
    String? guestName,
    DateTime? takenAt,
    String? sha256,
    int? width,
    int? height,
    int? sizeBytes,
  }) {
    return Shot(
      id: id is _isc.UndefinedSentinel ? this.id : id,
      spaceId: spaceId is int? ? spaceId : this.spaceId,
      eventId: eventId ?? this.eventId,
      rollId: rollId ?? this.rollId,
      guestName: guestName ?? this.guestName,
      takenAt: takenAt ?? this.takenAt,
      sha256: sha256 ?? this.sha256,
      width: width ?? this.width,
      height: height ?? this.height,
      sizeBytes: sizeBytes ?? this.sizeBytes,
    );
  }
}

class ShotUpdateTable extends _isd.UpdateTable<ShotTable> {
  ShotUpdateTable(super.table);

  _isd.ColumnValue<int, int> spaceId(int? value) => _isd.ColumnValue(
    table.spaceId,
    value,
  );

  _isd.ColumnValue<int, int> eventId(int value) => _isd.ColumnValue(
    table.eventId,
    value,
  );

  _isd.ColumnValue<int, int> rollId(int value) => _isd.ColumnValue(
    table.rollId,
    value,
  );

  _isd.ColumnValue<String, String> guestName(String value) => _isd.ColumnValue(
    table.guestName,
    value,
  );

  _isd.ColumnValue<DateTime, DateTime> takenAt(DateTime value) =>
      _isd.ColumnValue(
        table.takenAt,
        value,
      );

  _isd.ColumnValue<String, String> sha256(String value) => _isd.ColumnValue(
    table.sha256,
    value,
  );

  _isd.ColumnValue<int, int> width(int value) => _isd.ColumnValue(
    table.width,
    value,
  );

  _isd.ColumnValue<int, int> height(int value) => _isd.ColumnValue(
    table.height,
    value,
  );

  _isd.ColumnValue<int, int> sizeBytes(int value) => _isd.ColumnValue(
    table.sizeBytes,
    value,
  );
}

class ShotTable extends _isd.Table<_isc.UuidValue?> {
  ShotTable({super.tableRelation}) : super(tableName: 'shot') {
    updateTable = ShotUpdateTable(this);
    spaceId = _isd.ColumnInt(
      'spaceId',
      this,
    );
    eventId = _isd.ColumnInt(
      'eventId',
      this,
    );
    rollId = _isd.ColumnInt(
      'rollId',
      this,
    );
    guestName = _isd.ColumnString(
      'guestName',
      this,
    );
    takenAt = _isd.ColumnDateTime(
      'takenAt',
      this,
    );
    sha256 = _isd.ColumnString(
      'sha256',
      this,
    );
    width = _isd.ColumnInt(
      'width',
      this,
    );
    height = _isd.ColumnInt(
      'height',
      this,
    );
    sizeBytes = _isd.ColumnInt(
      'sizeBytes',
      this,
    );
  }

  late final ShotUpdateTable updateTable;

  /// The space owning this row. Maintained by the sync engine.
  late final _isd.ColumnInt spaceId;

  late final _isd.ColumnInt eventId;

  late final _isd.ColumnInt rollId;

  late final _isd.ColumnString guestName;

  /// The phone's clock when the shutter was pressed. A claim, not a fact.
  late final _isd.ColumnDateTime takenAt;

  late final _isd.ColumnString sha256;

  late final _isd.ColumnInt width;

  late final _isd.ColumnInt height;

  late final _isd.ColumnInt sizeBytes;

  @override
  List<_isd.Column> get columns => [
    id,
    spaceId,
    eventId,
    rollId,
    guestName,
    takenAt,
    sha256,
    width,
    height,
    sizeBytes,
  ];
}

class ShotInclude extends _isd.IncludeObject {
  ShotInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<_isc.UuidValue?> get table => Shot.t;
}

class ShotIncludeList extends _isd.IncludeList {
  ShotIncludeList._({
    _isd.WhereExpressionBuilder<ShotTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Shot.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => Shot.t;
}

class ShotRepository {
  const ShotRepository._();

  /// Returns a list of [Shot]s matching the given query parameters.
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
  Future<List<Shot>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<ShotTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<ShotTable>? orderBy,
    _isd.OrderByListBuilder<ShotTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Shot>(
      where: where?.call(Shot.t),
      orderBy: orderBy?.call(Shot.t),
      orderByList: orderByList?.call(Shot.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [Shot]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `Shot.t`.
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
  _ida.Stream<List<Shot>> watch(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<ShotTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<ShotTable>? orderBy,
    _isd.OrderByListBuilder<ShotTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_isd.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<Shot>(
      where: where?.call(Shot.t),
      orderBy: orderBy?.call(Shot.t),
      orderByList: orderByList?.call(Shot.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [Shot] matching the given query parameters.
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
  Future<Shot?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<ShotTable>? where,
    int? offset,
    _isd.OrderByBuilder<ShotTable>? orderBy,
    _isd.OrderByListBuilder<ShotTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Shot>(
      where: where?.call(Shot.t),
      orderBy: orderBy?.call(Shot.t),
      orderByList: orderByList?.call(Shot.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Shot] by its [id] or null if no such row exists.
  Future<Shot?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Shot>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Shot]s in the list and returns the inserted rows.
  ///
  /// The returned [Shot]s will have their `id` fields set.
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
  Future<List<Shot>> insert(
    _isd.DatabaseSession session,
    List<Shot> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Shot>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Shot] and returns the inserted row.
  ///
  /// The returned [Shot] will have its `id` field set.
  Future<Shot> insertRow(
    _isd.DatabaseSession session,
    Shot row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<Shot>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Shot]s in the list and returns the resulting rows.
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
  /// The returned [Shot]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Shot>> upsert(
    _isd.DatabaseSession session,
    List<Shot> rows, {
    required _isd.ColumnSelections<ShotTable> conflictColumns,
    _isd.ColumnSelections<ShotTable>? updateColumns,
    _isd.WhereExpressionBuilder<ShotTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Shot>(
      rows,
      conflictColumns: conflictColumns(Shot.t),
      updateColumns: updateColumns?.call(Shot.t),
      updateWhere: updateWhere?.call(Shot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Shot] and returns the resulting row.
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
  /// The returned [Shot] will have its `id` field set.
  Future<Shot?> upsertRow(
    _isd.DatabaseSession session,
    Shot row, {
    required _isd.ColumnSelections<ShotTable> conflictColumns,
    _isd.ColumnSelections<ShotTable>? updateColumns,
    _isd.WhereExpressionBuilder<ShotTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Shot>(
      row,
      conflictColumns: conflictColumns(Shot.t),
      updateColumns: updateColumns?.call(Shot.t),
      updateWhere: updateWhere?.call(Shot.t),
      transaction: transaction,
    );
  }

  /// Updates all [Shot]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Shot>> update(
    _isd.DatabaseSession session,
    List<Shot> rows, {
    _isd.ColumnSelections<ShotTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Shot>(
      rows,
      columns: columns?.call(Shot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Shot]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Shot> updateRow(
    _isd.DatabaseSession session,
    Shot row, {
    _isd.ColumnSelections<ShotTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<Shot>(
      row,
      columns: columns?.call(Shot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Shot] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Shot?> updateById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<ShotUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<Shot>(
      id,
      columnValues: columnValues(Shot.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Shot]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Shot>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<ShotUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<ShotTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<ShotTable>? orderBy,
    _isd.OrderByListBuilder<ShotTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Shot>(
      columnValues: columnValues(Shot.t.updateTable),
      where: where(Shot.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Shot.t),
      orderByList: orderByList?.call(Shot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Shot]s in the list and returns the deleted rows.
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
  Future<List<Shot>> delete(
    _isd.DatabaseSession session,
    List<Shot> rows, {
    _isd.OrderByBuilder<ShotTable>? orderBy,
    _isd.OrderByListBuilder<ShotTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Shot>(
      rows,
      orderBy: orderBy?.call(Shot.t),
      orderByList: orderByList?.call(Shot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Shot].
  Future<Shot> deleteRow(
    _isd.DatabaseSession session,
    Shot row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Shot>(
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
  Future<List<Shot>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<ShotTable> where,
    _isd.OrderByBuilder<ShotTable>? orderBy,
    _isd.OrderByListBuilder<ShotTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Shot>(
      where: where(Shot.t),
      orderBy: orderBy?.call(Shot.t),
      orderByList: orderByList?.call(Shot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<ShotTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<Shot>(
      where: where?.call(Shot.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Shot] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<ShotTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Shot>(
      where: where(Shot.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
