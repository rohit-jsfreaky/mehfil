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

/// A person who joined an event from the QR (anonymous sign-in + a name).
abstract class Guest implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Guest._({
    this.id,
    required this.eventId,
    required this.authUserId,
    required this.name,
    DateTime? joinedAt,
  }) : joinedAt = joinedAt ?? DateTime.now();

  factory Guest({
    int? id,
    required int eventId,
    required _is.UuidValue authUserId,
    required String name,
    DateTime? joinedAt,
  }) = _GuestImpl;

  factory Guest.fromJson(Map<String, dynamic> jsonSerialization) {
    return Guest(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      name: jsonSerialization['name'] as String,
      joinedAt: jsonSerialization['joinedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
    );
  }

  static final t = GuestTable();

  static const db = GuestRepository._();

  @override
  int? id;

  int eventId;

  _is.UuidValue authUserId;

  String name;

  DateTime joinedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Guest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Guest copyWith({
    int? id,
    int? eventId,
    _is.UuidValue? authUserId,
    String? name,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Guest',
      if (id != null) 'id': id,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'name': name,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Guest',
      if (id != null) 'id': id,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'name': name,
      'joinedAt': joinedAt.toJson(),
    };
  }

  static GuestInclude include() {
    return GuestInclude._();
  }

  static GuestIncludeList includeList({
    _is.WhereExpressionBuilder<GuestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    GuestInclude? include,
  }) {
    return GuestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GuestImpl extends Guest {
  _GuestImpl({
    int? id,
    required int eventId,
    required _is.UuidValue authUserId,
    required String name,
    DateTime? joinedAt,
  }) : super._(
         id: id,
         eventId: eventId,
         authUserId: authUserId,
         name: name,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [Guest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Guest copyWith({
    Object? id = _Undefined,
    int? eventId,
    _is.UuidValue? authUserId,
    String? name,
    DateTime? joinedAt,
  }) {
    return Guest(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      authUserId: authUserId ?? this.authUserId,
      name: name ?? this.name,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}

class GuestUpdateTable extends _is.UpdateTable<GuestTable> {
  GuestUpdateTable(super.table);

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _is.ColumnValue(
        table.joinedAt,
        value,
      );
}

class GuestTable extends _is.Table<int?> {
  GuestTable({super.tableRelation}) : super(tableName: 'guest') {
    updateTable = GuestUpdateTable(this);
    eventId = _is.ColumnInt(
      'eventId',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    joinedAt = _is.ColumnDateTime(
      'joinedAt',
      this,
      hasDefault: true,
    );
  }

  late final GuestUpdateTable updateTable;

  late final _is.ColumnInt eventId;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString name;

  late final _is.ColumnDateTime joinedAt;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    authUserId,
    name,
    joinedAt,
  ];
}

class GuestInclude extends _is.IncludeObject {
  GuestInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Guest.t;
}

class GuestIncludeList extends _is.IncludeList {
  GuestIncludeList._({
    _is.WhereExpressionBuilder<GuestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Guest.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Guest.t;
}

class GuestRepository {
  const GuestRepository._();

  /// Returns a list of [Guest]s matching the given query parameters.
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
  Future<List<Guest>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GuestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Guest>(
      where: where?.call(Guest.t),
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [Guest]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `Guest.t`.
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
  _ida.Stream<List<Guest>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GuestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<Guest>(
      where: where?.call(Guest.t),
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [Guest] matching the given query parameters.
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
  Future<Guest?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GuestTable>? where,
    int? offset,
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Guest>(
      where: where?.call(Guest.t),
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Guest] by its [id] or null if no such row exists.
  Future<Guest?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Guest>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Guest]s in the list and returns the inserted rows.
  ///
  /// The returned [Guest]s will have their `id` fields set.
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
  Future<List<Guest>> insert(
    _is.DatabaseSession session,
    List<Guest> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Guest>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Guest] and returns the inserted row.
  ///
  /// The returned [Guest] will have its `id` field set.
  Future<Guest> insertRow(
    _is.DatabaseSession session,
    Guest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Guest>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Guest]s in the list and returns the resulting rows.
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
  /// The returned [Guest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Guest>> upsert(
    _is.DatabaseSession session,
    List<Guest> rows, {
    required _is.ColumnSelections<GuestTable> conflictColumns,
    _is.ColumnSelections<GuestTable>? updateColumns,
    _is.WhereExpressionBuilder<GuestTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Guest>(
      rows,
      conflictColumns: conflictColumns(Guest.t),
      updateColumns: updateColumns?.call(Guest.t),
      updateWhere: updateWhere?.call(Guest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Guest] and returns the resulting row.
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
  /// The returned [Guest] will have its `id` field set.
  Future<Guest?> upsertRow(
    _is.DatabaseSession session,
    Guest row, {
    required _is.ColumnSelections<GuestTable> conflictColumns,
    _is.ColumnSelections<GuestTable>? updateColumns,
    _is.WhereExpressionBuilder<GuestTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Guest>(
      row,
      conflictColumns: conflictColumns(Guest.t),
      updateColumns: updateColumns?.call(Guest.t),
      updateWhere: updateWhere?.call(Guest.t),
      transaction: transaction,
    );
  }

  /// Updates all [Guest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Guest>> update(
    _is.DatabaseSession session,
    List<Guest> rows, {
    _is.ColumnSelections<GuestTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Guest>(
      rows,
      columns: columns?.call(Guest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Guest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Guest> updateRow(
    _is.DatabaseSession session,
    Guest row, {
    _is.ColumnSelections<GuestTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Guest>(
      row,
      columns: columns?.call(Guest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Guest] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Guest?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<GuestUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Guest>(
      id,
      columnValues: columnValues(Guest.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Guest]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Guest>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<GuestUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<GuestTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Guest>(
      columnValues: columnValues(Guest.t.updateTable),
      where: where(Guest.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Guest]s in the list and returns the deleted rows.
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
  Future<List<Guest>> delete(
    _is.DatabaseSession session,
    List<Guest> rows, {
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Guest>(
      rows,
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Guest].
  Future<Guest> deleteRow(
    _is.DatabaseSession session,
    Guest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Guest>(
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
  Future<List<Guest>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<GuestTable> where,
    _is.OrderByBuilder<GuestTable>? orderBy,
    _is.OrderByListBuilder<GuestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Guest>(
      where: where(Guest.t),
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GuestTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Guest>(
      where: where?.call(Guest.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Guest] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<GuestTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Guest>(
      where: where(Guest.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
