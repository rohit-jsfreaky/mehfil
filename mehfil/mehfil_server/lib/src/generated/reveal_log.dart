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

/// One row per revealed roll. The unique index is what makes a reveal happen
/// exactly once, whoever triggers it (the future call or the host).
abstract class RevealLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RevealLog._({
    this.id,
    required this.rollId,
    required this.trigger,
    required this.photos,
    required this.revealedAt,
  });

  factory RevealLog({
    int? id,
    required int rollId,
    required String trigger,
    required int photos,
    required DateTime revealedAt,
  }) = _RevealLogImpl;

  factory RevealLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return RevealLog(
      id: jsonSerialization['id'] as int?,
      rollId: jsonSerialization['rollId'] as int,
      trigger: jsonSerialization['trigger'] as String,
      photos: jsonSerialization['photos'] as int,
      revealedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['revealedAt'],
      ),
    );
  }

  static final t = RevealLogTable();

  static const db = RevealLogRepository._();

  @override
  int? id;

  int rollId;

  /// "schedule" (the future call) or "host" (Reveal now).
  String trigger;

  int photos;

  DateTime revealedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RevealLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RevealLog copyWith({
    int? id,
    int? rollId,
    String? trigger,
    int? photos,
    DateTime? revealedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RevealLog',
      if (id != null) 'id': id,
      'rollId': rollId,
      'trigger': trigger,
      'photos': photos,
      'revealedAt': revealedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RevealLog',
      if (id != null) 'id': id,
      'rollId': rollId,
      'trigger': trigger,
      'photos': photos,
      'revealedAt': revealedAt.toJson(),
    };
  }

  static RevealLogInclude include() {
    return RevealLogInclude._();
  }

  static RevealLogIncludeList includeList({
    _is.WhereExpressionBuilder<RevealLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RevealLogTable>? orderBy,
    _is.OrderByListBuilder<RevealLogTable>? orderByList,
    RevealLogInclude? include,
  }) {
    return RevealLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RevealLog.t),
      orderByList: orderByList?.call(RevealLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RevealLogImpl extends RevealLog {
  _RevealLogImpl({
    int? id,
    required int rollId,
    required String trigger,
    required int photos,
    required DateTime revealedAt,
  }) : super._(
         id: id,
         rollId: rollId,
         trigger: trigger,
         photos: photos,
         revealedAt: revealedAt,
       );

  /// Returns a shallow copy of this [RevealLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RevealLog copyWith({
    Object? id = _Undefined,
    int? rollId,
    String? trigger,
    int? photos,
    DateTime? revealedAt,
  }) {
    return RevealLog(
      id: id is int? ? id : this.id,
      rollId: rollId ?? this.rollId,
      trigger: trigger ?? this.trigger,
      photos: photos ?? this.photos,
      revealedAt: revealedAt ?? this.revealedAt,
    );
  }
}

class RevealLogUpdateTable extends _is.UpdateTable<RevealLogTable> {
  RevealLogUpdateTable(super.table);

  _is.ColumnValue<int, int> rollId(int value) => _is.ColumnValue(
    table.rollId,
    value,
  );

  _is.ColumnValue<String, String> trigger(String value) => _is.ColumnValue(
    table.trigger,
    value,
  );

  _is.ColumnValue<int, int> photos(int value) => _is.ColumnValue(
    table.photos,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> revealedAt(DateTime value) =>
      _is.ColumnValue(
        table.revealedAt,
        value,
      );
}

class RevealLogTable extends _is.Table<int?> {
  RevealLogTable({super.tableRelation}) : super(tableName: 'reveal_log') {
    updateTable = RevealLogUpdateTable(this);
    rollId = _is.ColumnInt(
      'rollId',
      this,
    );
    trigger = _is.ColumnString(
      'trigger',
      this,
    );
    photos = _is.ColumnInt(
      'photos',
      this,
    );
    revealedAt = _is.ColumnDateTime(
      'revealedAt',
      this,
    );
  }

  late final RevealLogUpdateTable updateTable;

  late final _is.ColumnInt rollId;

  /// "schedule" (the future call) or "host" (Reveal now).
  late final _is.ColumnString trigger;

  late final _is.ColumnInt photos;

  late final _is.ColumnDateTime revealedAt;

  @override
  List<_is.Column> get columns => [
    id,
    rollId,
    trigger,
    photos,
    revealedAt,
  ];
}

class RevealLogInclude extends _is.IncludeObject {
  RevealLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RevealLog.t;
}

class RevealLogIncludeList extends _is.IncludeList {
  RevealLogIncludeList._({
    _is.WhereExpressionBuilder<RevealLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RevealLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RevealLog.t;
}

class RevealLogRepository {
  const RevealLogRepository._();

  /// Returns a list of [RevealLog]s matching the given query parameters.
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
  Future<List<RevealLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RevealLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RevealLogTable>? orderBy,
    _is.OrderByListBuilder<RevealLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RevealLog>(
      where: where?.call(RevealLog.t),
      orderBy: orderBy?.call(RevealLog.t),
      orderByList: orderByList?.call(RevealLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [RevealLog]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `RevealLog.t`.
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
  _ida.Stream<List<RevealLog>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RevealLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RevealLogTable>? orderBy,
    _is.OrderByListBuilder<RevealLogTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<RevealLog>(
      where: where?.call(RevealLog.t),
      orderBy: orderBy?.call(RevealLog.t),
      orderByList: orderByList?.call(RevealLog.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [RevealLog] matching the given query parameters.
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
  Future<RevealLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RevealLogTable>? where,
    int? offset,
    _is.OrderByBuilder<RevealLogTable>? orderBy,
    _is.OrderByListBuilder<RevealLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RevealLog>(
      where: where?.call(RevealLog.t),
      orderBy: orderBy?.call(RevealLog.t),
      orderByList: orderByList?.call(RevealLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RevealLog] by its [id] or null if no such row exists.
  Future<RevealLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RevealLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RevealLog]s in the list and returns the inserted rows.
  ///
  /// The returned [RevealLog]s will have their `id` fields set.
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
  Future<List<RevealLog>> insert(
    _is.DatabaseSession session,
    List<RevealLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RevealLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RevealLog] and returns the inserted row.
  ///
  /// The returned [RevealLog] will have its `id` field set.
  Future<RevealLog> insertRow(
    _is.DatabaseSession session,
    RevealLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RevealLog>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RevealLog]s in the list and returns the resulting rows.
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
  /// The returned [RevealLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RevealLog>> upsert(
    _is.DatabaseSession session,
    List<RevealLog> rows, {
    required _is.ColumnSelections<RevealLogTable> conflictColumns,
    _is.ColumnSelections<RevealLogTable>? updateColumns,
    _is.WhereExpressionBuilder<RevealLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RevealLog>(
      rows,
      conflictColumns: conflictColumns(RevealLog.t),
      updateColumns: updateColumns?.call(RevealLog.t),
      updateWhere: updateWhere?.call(RevealLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RevealLog] and returns the resulting row.
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
  /// The returned [RevealLog] will have its `id` field set.
  Future<RevealLog?> upsertRow(
    _is.DatabaseSession session,
    RevealLog row, {
    required _is.ColumnSelections<RevealLogTable> conflictColumns,
    _is.ColumnSelections<RevealLogTable>? updateColumns,
    _is.WhereExpressionBuilder<RevealLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RevealLog>(
      row,
      conflictColumns: conflictColumns(RevealLog.t),
      updateColumns: updateColumns?.call(RevealLog.t),
      updateWhere: updateWhere?.call(RevealLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [RevealLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RevealLog>> update(
    _is.DatabaseSession session,
    List<RevealLog> rows, {
    _is.ColumnSelections<RevealLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RevealLog>(
      rows,
      columns: columns?.call(RevealLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RevealLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RevealLog> updateRow(
    _is.DatabaseSession session,
    RevealLog row, {
    _is.ColumnSelections<RevealLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RevealLog>(
      row,
      columns: columns?.call(RevealLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RevealLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RevealLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RevealLogUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RevealLog>(
      id,
      columnValues: columnValues(RevealLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RevealLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RevealLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RevealLogUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RevealLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RevealLogTable>? orderBy,
    _is.OrderByListBuilder<RevealLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RevealLog>(
      columnValues: columnValues(RevealLog.t.updateTable),
      where: where(RevealLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RevealLog.t),
      orderByList: orderByList?.call(RevealLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RevealLog]s in the list and returns the deleted rows.
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
  Future<List<RevealLog>> delete(
    _is.DatabaseSession session,
    List<RevealLog> rows, {
    _is.OrderByBuilder<RevealLogTable>? orderBy,
    _is.OrderByListBuilder<RevealLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RevealLog>(
      rows,
      orderBy: orderBy?.call(RevealLog.t),
      orderByList: orderByList?.call(RevealLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RevealLog].
  Future<RevealLog> deleteRow(
    _is.DatabaseSession session,
    RevealLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RevealLog>(
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
  Future<List<RevealLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RevealLogTable> where,
    _is.OrderByBuilder<RevealLogTable>? orderBy,
    _is.OrderByListBuilder<RevealLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RevealLog>(
      where: where(RevealLog.t),
      orderBy: orderBy?.call(RevealLog.t),
      orderByList: orderByList?.call(RevealLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RevealLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RevealLog>(
      where: where?.call(RevealLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RevealLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RevealLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RevealLog>(
      where: where(RevealLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
