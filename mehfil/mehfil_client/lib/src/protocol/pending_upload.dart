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
import 'dart:typed_data' as _idt;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;

/// The phone-side queue: the photo bytes wait here (SQLite on the device, or
/// in the browser) until the server confirms it has them.
abstract class PendingUpload
    implements _isd.TableRow<int?>, _isc.ProtocolSerialization {
  PendingUpload._({
    this.id,
    required this.shotId,
    required this.eventId,
    required this.rollId,
    required this.bytes,
    required this.createdAt,
    int? attempts,
    this.lastError,
  }) : attempts = attempts ?? 0;

  factory PendingUpload({
    int? id,
    required _isc.UuidValue shotId,
    required int eventId,
    required int rollId,
    required _idt.ByteData bytes,
    required DateTime createdAt,
    int? attempts,
    String? lastError,
  }) = _PendingUploadImpl;

  factory PendingUpload.fromJson(Map<String, dynamic> jsonSerialization) {
    return PendingUpload(
      id: jsonSerialization['id'] as int?,
      shotId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['shotId']),
      eventId: jsonSerialization['eventId'] as int,
      rollId: jsonSerialization['rollId'] as int,
      bytes: _isc.ByteDataJsonExtension.fromJson(jsonSerialization['bytes']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      attempts: jsonSerialization['attempts'] as int?,
      lastError: jsonSerialization['lastError'] as String?,
    );
  }

  static final t = PendingUploadTable();

  static const db = PendingUploadRepository._();

  @override
  int? id;

  _isc.UuidValue shotId;

  int eventId;

  int rollId;

  _idt.ByteData bytes;

  DateTime createdAt;

  int attempts;

  String? lastError;

  @override
  _isd.Table<int?> get table => t;

  /// Returns a shallow copy of this [PendingUpload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PendingUpload copyWith({
    int? id,
    _isc.UuidValue? shotId,
    int? eventId,
    int? rollId,
    _idt.ByteData? bytes,
    DateTime? createdAt,
    int? attempts,
    String? lastError,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PendingUpload',
      if (id != null) 'id': id,
      'shotId': shotId.toJson(),
      'eventId': eventId,
      'rollId': rollId,
      'bytes': bytes.toJson(),
      'createdAt': createdAt.toJson(),
      'attempts': attempts,
      if (lastError != null) 'lastError': lastError,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PendingUpload',
      if (id != null) 'id': id,
      'shotId': shotId.toJson(),
      'eventId': eventId,
      'rollId': rollId,
      'bytes': bytes.toJson(),
      'createdAt': createdAt.toJson(),
      'attempts': attempts,
      if (lastError != null) 'lastError': lastError,
    };
  }

  static PendingUploadInclude include() {
    return PendingUploadInclude._();
  }

  static PendingUploadIncludeList includeList({
    _isd.WhereExpressionBuilder<PendingUploadTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<PendingUploadTable>? orderBy,
    _isd.OrderByListBuilder<PendingUploadTable>? orderByList,
    PendingUploadInclude? include,
  }) {
    return PendingUploadIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PendingUpload.t),
      orderByList: orderByList?.call(PendingUpload.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PendingUploadImpl extends PendingUpload {
  _PendingUploadImpl({
    int? id,
    required _isc.UuidValue shotId,
    required int eventId,
    required int rollId,
    required _idt.ByteData bytes,
    required DateTime createdAt,
    int? attempts,
    String? lastError,
  }) : super._(
         id: id,
         shotId: shotId,
         eventId: eventId,
         rollId: rollId,
         bytes: bytes,
         createdAt: createdAt,
         attempts: attempts,
         lastError: lastError,
       );

  /// Returns a shallow copy of this [PendingUpload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PendingUpload copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? shotId,
    int? eventId,
    int? rollId,
    _idt.ByteData? bytes,
    DateTime? createdAt,
    int? attempts,
    Object? lastError = _Undefined,
  }) {
    return PendingUpload(
      id: id is int? ? id : this.id,
      shotId: shotId ?? this.shotId,
      eventId: eventId ?? this.eventId,
      rollId: rollId ?? this.rollId,
      bytes: bytes ?? this.bytes.clone(),
      createdAt: createdAt ?? this.createdAt,
      attempts: attempts ?? this.attempts,
      lastError: lastError is String? ? lastError : this.lastError,
    );
  }
}

class PendingUploadUpdateTable extends _isd.UpdateTable<PendingUploadTable> {
  PendingUploadUpdateTable(super.table);

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> shotId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.shotId,
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

  _isd.ColumnValue<_idt.ByteData, _idt.ByteData> bytes(_idt.ByteData value) =>
      _isd.ColumnValue(
        table.bytes,
        value,
      );

  _isd.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _isd.ColumnValue(
        table.createdAt,
        value,
      );

  _isd.ColumnValue<int, int> attempts(int value) => _isd.ColumnValue(
    table.attempts,
    value,
  );

  _isd.ColumnValue<String, String> lastError(String? value) => _isd.ColumnValue(
    table.lastError,
    value,
  );
}

class PendingUploadTable extends _isd.Table<int?> {
  PendingUploadTable({super.tableRelation})
    : super(tableName: 'pending_upload') {
    updateTable = PendingUploadUpdateTable(this);
    shotId = _isd.ColumnUuid(
      'shotId',
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
    bytes = _isd.ColumnByteData(
      'bytes',
      this,
    );
    createdAt = _isd.ColumnDateTime(
      'createdAt',
      this,
    );
    attempts = _isd.ColumnInt(
      'attempts',
      this,
      hasDefault: true,
    );
    lastError = _isd.ColumnString(
      'lastError',
      this,
    );
  }

  late final PendingUploadUpdateTable updateTable;

  late final _isd.ColumnUuid shotId;

  late final _isd.ColumnInt eventId;

  late final _isd.ColumnInt rollId;

  late final _isd.ColumnByteData bytes;

  late final _isd.ColumnDateTime createdAt;

  late final _isd.ColumnInt attempts;

  late final _isd.ColumnString lastError;

  @override
  List<_isd.Column> get columns => [
    id,
    shotId,
    eventId,
    rollId,
    bytes,
    createdAt,
    attempts,
    lastError,
  ];
}

class PendingUploadInclude extends _isd.IncludeObject {
  PendingUploadInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<int?> get table => PendingUpload.t;
}

class PendingUploadIncludeList extends _isd.IncludeList {
  PendingUploadIncludeList._({
    _isd.WhereExpressionBuilder<PendingUploadTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PendingUpload.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<int?> get table => PendingUpload.t;
}

class PendingUploadRepository {
  const PendingUploadRepository._();

  /// Returns a list of [PendingUpload]s matching the given query parameters.
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
  Future<List<PendingUpload>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<PendingUploadTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<PendingUploadTable>? orderBy,
    _isd.OrderByListBuilder<PendingUploadTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PendingUpload>(
      where: where?.call(PendingUpload.t),
      orderBy: orderBy?.call(PendingUpload.t),
      orderByList: orderByList?.call(PendingUpload.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [PendingUpload]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `PendingUpload.t`.
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
  _ida.Stream<List<PendingUpload>> watch(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<PendingUploadTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<PendingUploadTable>? orderBy,
    _isd.OrderByListBuilder<PendingUploadTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_isd.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<PendingUpload>(
      where: where?.call(PendingUpload.t),
      orderBy: orderBy?.call(PendingUpload.t),
      orderByList: orderByList?.call(PendingUpload.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [PendingUpload] matching the given query parameters.
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
  Future<PendingUpload?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<PendingUploadTable>? where,
    int? offset,
    _isd.OrderByBuilder<PendingUploadTable>? orderBy,
    _isd.OrderByListBuilder<PendingUploadTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PendingUpload>(
      where: where?.call(PendingUpload.t),
      orderBy: orderBy?.call(PendingUpload.t),
      orderByList: orderByList?.call(PendingUpload.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PendingUpload] by its [id] or null if no such row exists.
  Future<PendingUpload?> findById(
    _isd.DatabaseSession session,
    int id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PendingUpload>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PendingUpload]s in the list and returns the inserted rows.
  ///
  /// The returned [PendingUpload]s will have their `id` fields set.
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
  Future<List<PendingUpload>> insert(
    _isd.DatabaseSession session,
    List<PendingUpload> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PendingUpload>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PendingUpload] and returns the inserted row.
  ///
  /// The returned [PendingUpload] will have its `id` field set.
  Future<PendingUpload> insertRow(
    _isd.DatabaseSession session,
    PendingUpload row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<PendingUpload>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PendingUpload]s in the list and returns the resulting rows.
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
  /// The returned [PendingUpload]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PendingUpload>> upsert(
    _isd.DatabaseSession session,
    List<PendingUpload> rows, {
    required _isd.ColumnSelections<PendingUploadTable> conflictColumns,
    _isd.ColumnSelections<PendingUploadTable>? updateColumns,
    _isd.WhereExpressionBuilder<PendingUploadTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PendingUpload>(
      rows,
      conflictColumns: conflictColumns(PendingUpload.t),
      updateColumns: updateColumns?.call(PendingUpload.t),
      updateWhere: updateWhere?.call(PendingUpload.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PendingUpload] and returns the resulting row.
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
  /// The returned [PendingUpload] will have its `id` field set.
  Future<PendingUpload?> upsertRow(
    _isd.DatabaseSession session,
    PendingUpload row, {
    required _isd.ColumnSelections<PendingUploadTable> conflictColumns,
    _isd.ColumnSelections<PendingUploadTable>? updateColumns,
    _isd.WhereExpressionBuilder<PendingUploadTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PendingUpload>(
      row,
      conflictColumns: conflictColumns(PendingUpload.t),
      updateColumns: updateColumns?.call(PendingUpload.t),
      updateWhere: updateWhere?.call(PendingUpload.t),
      transaction: transaction,
    );
  }

  /// Updates all [PendingUpload]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PendingUpload>> update(
    _isd.DatabaseSession session,
    List<PendingUpload> rows, {
    _isd.ColumnSelections<PendingUploadTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PendingUpload>(
      rows,
      columns: columns?.call(PendingUpload.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PendingUpload]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PendingUpload> updateRow(
    _isd.DatabaseSession session,
    PendingUpload row, {
    _isd.ColumnSelections<PendingUploadTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<PendingUpload>(
      row,
      columns: columns?.call(PendingUpload.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PendingUpload] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PendingUpload?> updateById(
    _isd.DatabaseSession session,
    int id, {
    required _isd.ColumnValueListBuilder<PendingUploadUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<PendingUpload>(
      id,
      columnValues: columnValues(PendingUpload.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PendingUpload]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PendingUpload>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<PendingUploadUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<PendingUploadTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<PendingUploadTable>? orderBy,
    _isd.OrderByListBuilder<PendingUploadTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PendingUpload>(
      columnValues: columnValues(PendingUpload.t.updateTable),
      where: where(PendingUpload.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PendingUpload.t),
      orderByList: orderByList?.call(PendingUpload.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PendingUpload]s in the list and returns the deleted rows.
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
  Future<List<PendingUpload>> delete(
    _isd.DatabaseSession session,
    List<PendingUpload> rows, {
    _isd.OrderByBuilder<PendingUploadTable>? orderBy,
    _isd.OrderByListBuilder<PendingUploadTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PendingUpload>(
      rows,
      orderBy: orderBy?.call(PendingUpload.t),
      orderByList: orderByList?.call(PendingUpload.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PendingUpload].
  Future<PendingUpload> deleteRow(
    _isd.DatabaseSession session,
    PendingUpload row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PendingUpload>(
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
  Future<List<PendingUpload>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<PendingUploadTable> where,
    _isd.OrderByBuilder<PendingUploadTable>? orderBy,
    _isd.OrderByListBuilder<PendingUploadTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PendingUpload>(
      where: where(PendingUpload.t),
      orderBy: orderBy?.call(PendingUpload.t),
      orderByList: orderByList?.call(PendingUpload.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<PendingUploadTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<PendingUpload>(
      where: where?.call(PendingUpload.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PendingUpload] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<PendingUploadTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PendingUpload>(
      where: where(PendingUpload.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
