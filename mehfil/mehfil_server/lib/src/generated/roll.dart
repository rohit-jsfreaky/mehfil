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

/// One function of the event (Haldi, Sangeet...). Its photos stay hidden until
/// [revealAt]; the reveal future call sets [revealedAt].
abstract class Roll implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      revealAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['revealAt'],
      ),
      revealedAt: jsonSerialization['revealedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['revealedAt']),
      shotsPerGuest: jsonSerialization['shotsPerGuest'] as int?,
    );
  }

  static final t = RollTable();

  static const db = RollRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Roll]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Roll copyWith({
    int? id,
    int? eventId,
    String? name,
    int? sortOrder,
    DateTime? revealAt,
    DateTime? revealedAt = const _is.$UndefinedDateTime(),
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

  static RollInclude include() {
    return RollInclude._();
  }

  static RollIncludeList includeList({
    _is.WhereExpressionBuilder<RollTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RollTable>? orderBy,
    _is.OrderByListBuilder<RollTable>? orderByList,
    RollInclude? include,
  }) {
    return RollIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Roll.t),
      orderByList: orderByList?.call(Roll.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
  @override
  Roll copyWith({
    Object? id = _Undefined,
    int? eventId,
    String? name,
    int? sortOrder,
    DateTime? revealAt,
    DateTime? revealedAt = const _is.$UndefinedDateTime(),
    int? shotsPerGuest,
  }) {
    return Roll(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      revealAt: revealAt ?? this.revealAt,
      revealedAt: revealedAt is _is.UndefinedSentinel
          ? this.revealedAt
          : revealedAt,
      shotsPerGuest: shotsPerGuest ?? this.shotsPerGuest,
    );
  }
}

class RollUpdateTable extends _is.UpdateTable<RollTable> {
  RollUpdateTable(super.table);

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<int, int> sortOrder(int value) => _is.ColumnValue(
    table.sortOrder,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> revealAt(DateTime value) =>
      _is.ColumnValue(
        table.revealAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> revealedAt(DateTime? value) =>
      _is.ColumnValue(
        table.revealedAt,
        value,
      );

  _is.ColumnValue<int, int> shotsPerGuest(int value) => _is.ColumnValue(
    table.shotsPerGuest,
    value,
  );
}

class RollTable extends _is.Table<int?> {
  RollTable({super.tableRelation}) : super(tableName: 'roll') {
    updateTable = RollUpdateTable(this);
    eventId = _is.ColumnInt(
      'eventId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    sortOrder = _is.ColumnInt(
      'sortOrder',
      this,
      hasDefault: true,
    );
    revealAt = _is.ColumnDateTime(
      'revealAt',
      this,
    );
    revealedAt = _is.ColumnDateTime(
      'revealedAt',
      this,
    );
    shotsPerGuest = _is.ColumnInt(
      'shotsPerGuest',
      this,
      hasDefault: true,
    );
  }

  late final RollUpdateTable updateTable;

  late final _is.ColumnInt eventId;

  late final _is.ColumnString name;

  late final _is.ColumnInt sortOrder;

  /// Server time (UTC) when the album opens for everyone.
  late final _is.ColumnDateTime revealAt;

  /// Set once, by the reveal. Null means the roll is still hidden.
  late final _is.ColumnDateTime revealedAt;

  /// Like a disposable camera: how many shots each guest gets on this roll.
  late final _is.ColumnInt shotsPerGuest;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    name,
    sortOrder,
    revealAt,
    revealedAt,
    shotsPerGuest,
  ];
}

class RollInclude extends _is.IncludeObject {
  RollInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Roll.t;
}

class RollIncludeList extends _is.IncludeList {
  RollIncludeList._({
    _is.WhereExpressionBuilder<RollTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Roll.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Roll.t;
}

class RollRepository {
  const RollRepository._();

  /// Returns a list of [Roll]s matching the given query parameters.
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
  Future<List<Roll>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RollTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RollTable>? orderBy,
    _is.OrderByListBuilder<RollTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Roll>(
      where: where?.call(Roll.t),
      orderBy: orderBy?.call(Roll.t),
      orderByList: orderByList?.call(Roll.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [Roll]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `Roll.t`.
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
  _ida.Stream<List<Roll>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RollTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RollTable>? orderBy,
    _is.OrderByListBuilder<RollTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<Roll>(
      where: where?.call(Roll.t),
      orderBy: orderBy?.call(Roll.t),
      orderByList: orderByList?.call(Roll.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [Roll] matching the given query parameters.
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
  Future<Roll?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RollTable>? where,
    int? offset,
    _is.OrderByBuilder<RollTable>? orderBy,
    _is.OrderByListBuilder<RollTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Roll>(
      where: where?.call(Roll.t),
      orderBy: orderBy?.call(Roll.t),
      orderByList: orderByList?.call(Roll.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Roll] by its [id] or null if no such row exists.
  Future<Roll?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Roll>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Roll]s in the list and returns the inserted rows.
  ///
  /// The returned [Roll]s will have their `id` fields set.
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
  Future<List<Roll>> insert(
    _is.DatabaseSession session,
    List<Roll> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Roll>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Roll] and returns the inserted row.
  ///
  /// The returned [Roll] will have its `id` field set.
  Future<Roll> insertRow(
    _is.DatabaseSession session,
    Roll row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Roll>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Roll]s in the list and returns the resulting rows.
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
  /// The returned [Roll]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Roll>> upsert(
    _is.DatabaseSession session,
    List<Roll> rows, {
    required _is.ColumnSelections<RollTable> conflictColumns,
    _is.ColumnSelections<RollTable>? updateColumns,
    _is.WhereExpressionBuilder<RollTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Roll>(
      rows,
      conflictColumns: conflictColumns(Roll.t),
      updateColumns: updateColumns?.call(Roll.t),
      updateWhere: updateWhere?.call(Roll.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Roll] and returns the resulting row.
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
  /// The returned [Roll] will have its `id` field set.
  Future<Roll?> upsertRow(
    _is.DatabaseSession session,
    Roll row, {
    required _is.ColumnSelections<RollTable> conflictColumns,
    _is.ColumnSelections<RollTable>? updateColumns,
    _is.WhereExpressionBuilder<RollTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Roll>(
      row,
      conflictColumns: conflictColumns(Roll.t),
      updateColumns: updateColumns?.call(Roll.t),
      updateWhere: updateWhere?.call(Roll.t),
      transaction: transaction,
    );
  }

  /// Updates all [Roll]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Roll>> update(
    _is.DatabaseSession session,
    List<Roll> rows, {
    _is.ColumnSelections<RollTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Roll>(
      rows,
      columns: columns?.call(Roll.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Roll]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Roll> updateRow(
    _is.DatabaseSession session,
    Roll row, {
    _is.ColumnSelections<RollTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Roll>(
      row,
      columns: columns?.call(Roll.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Roll] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Roll?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RollUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Roll>(
      id,
      columnValues: columnValues(Roll.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Roll]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Roll>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RollUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RollTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RollTable>? orderBy,
    _is.OrderByListBuilder<RollTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Roll>(
      columnValues: columnValues(Roll.t.updateTable),
      where: where(Roll.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Roll.t),
      orderByList: orderByList?.call(Roll.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Roll]s in the list and returns the deleted rows.
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
  Future<List<Roll>> delete(
    _is.DatabaseSession session,
    List<Roll> rows, {
    _is.OrderByBuilder<RollTable>? orderBy,
    _is.OrderByListBuilder<RollTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Roll>(
      rows,
      orderBy: orderBy?.call(Roll.t),
      orderByList: orderByList?.call(Roll.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Roll].
  Future<Roll> deleteRow(
    _is.DatabaseSession session,
    Roll row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Roll>(
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
  Future<List<Roll>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RollTable> where,
    _is.OrderByBuilder<RollTable>? orderBy,
    _is.OrderByListBuilder<RollTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Roll>(
      where: where(Roll.t),
      orderBy: orderBy?.call(Roll.t),
      orderByList: orderByList?.call(Roll.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RollTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Roll>(
      where: where?.call(Roll.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Roll] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RollTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Roll>(
      where: where(Roll.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
