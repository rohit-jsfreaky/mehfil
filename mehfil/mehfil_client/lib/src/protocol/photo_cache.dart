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

/// Phone-side copy of revealed photos, so the album opens with no signal.
abstract class PhotoCache
    implements _isd.TableRow<int?>, _isc.ProtocolSerialization {
  PhotoCache._({
    this.id,
    required this.shotId,
    required this.thumb,
    required this.bytes,
    required this.savedAt,
  });

  factory PhotoCache({
    int? id,
    required _isc.UuidValue shotId,
    required bool thumb,
    required _idt.ByteData bytes,
    required DateTime savedAt,
  }) = _PhotoCacheImpl;

  factory PhotoCache.fromJson(Map<String, dynamic> jsonSerialization) {
    return PhotoCache(
      id: jsonSerialization['id'] as int?,
      shotId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['shotId']),
      thumb: _isc.BoolJsonExtension.fromJson(jsonSerialization['thumb']),
      bytes: _isc.ByteDataJsonExtension.fromJson(jsonSerialization['bytes']),
      savedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['savedAt'],
      ),
    );
  }

  static final t = PhotoCacheTable();

  static const db = PhotoCacheRepository._();

  @override
  int? id;

  _isc.UuidValue shotId;

  bool thumb;

  _idt.ByteData bytes;

  DateTime savedAt;

  @override
  _isd.Table<int?> get table => t;

  /// Returns a shallow copy of this [PhotoCache]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PhotoCache copyWith({
    int? id,
    _isc.UuidValue? shotId,
    bool? thumb,
    _idt.ByteData? bytes,
    DateTime? savedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PhotoCache',
      if (id != null) 'id': id,
      'shotId': shotId.toJson(),
      'thumb': thumb,
      'bytes': bytes.toJson(),
      'savedAt': savedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PhotoCache',
      if (id != null) 'id': id,
      'shotId': shotId.toJson(),
      'thumb': thumb,
      'bytes': bytes.toJson(),
      'savedAt': savedAt.toJson(),
    };
  }

  static PhotoCacheInclude include() {
    return PhotoCacheInclude._();
  }

  static PhotoCacheIncludeList includeList({
    _isd.WhereExpressionBuilder<PhotoCacheTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<PhotoCacheTable>? orderBy,
    _isd.OrderByListBuilder<PhotoCacheTable>? orderByList,
    PhotoCacheInclude? include,
  }) {
    return PhotoCacheIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PhotoCache.t),
      orderByList: orderByList?.call(PhotoCache.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PhotoCacheImpl extends PhotoCache {
  _PhotoCacheImpl({
    int? id,
    required _isc.UuidValue shotId,
    required bool thumb,
    required _idt.ByteData bytes,
    required DateTime savedAt,
  }) : super._(
         id: id,
         shotId: shotId,
         thumb: thumb,
         bytes: bytes,
         savedAt: savedAt,
       );

  /// Returns a shallow copy of this [PhotoCache]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PhotoCache copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? shotId,
    bool? thumb,
    _idt.ByteData? bytes,
    DateTime? savedAt,
  }) {
    return PhotoCache(
      id: id is int? ? id : this.id,
      shotId: shotId ?? this.shotId,
      thumb: thumb ?? this.thumb,
      bytes: bytes ?? this.bytes.clone(),
      savedAt: savedAt ?? this.savedAt,
    );
  }
}

class PhotoCacheUpdateTable extends _isd.UpdateTable<PhotoCacheTable> {
  PhotoCacheUpdateTable(super.table);

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> shotId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.shotId,
    value,
  );

  _isd.ColumnValue<bool, bool> thumb(bool value) => _isd.ColumnValue(
    table.thumb,
    value,
  );

  _isd.ColumnValue<_idt.ByteData, _idt.ByteData> bytes(_idt.ByteData value) =>
      _isd.ColumnValue(
        table.bytes,
        value,
      );

  _isd.ColumnValue<DateTime, DateTime> savedAt(DateTime value) =>
      _isd.ColumnValue(
        table.savedAt,
        value,
      );
}

class PhotoCacheTable extends _isd.Table<int?> {
  PhotoCacheTable({super.tableRelation}) : super(tableName: 'photo_cache') {
    updateTable = PhotoCacheUpdateTable(this);
    shotId = _isd.ColumnUuid(
      'shotId',
      this,
    );
    thumb = _isd.ColumnBool(
      'thumb',
      this,
    );
    bytes = _isd.ColumnByteData(
      'bytes',
      this,
    );
    savedAt = _isd.ColumnDateTime(
      'savedAt',
      this,
    );
  }

  late final PhotoCacheUpdateTable updateTable;

  late final _isd.ColumnUuid shotId;

  late final _isd.ColumnBool thumb;

  late final _isd.ColumnByteData bytes;

  late final _isd.ColumnDateTime savedAt;

  @override
  List<_isd.Column> get columns => [
    id,
    shotId,
    thumb,
    bytes,
    savedAt,
  ];
}

class PhotoCacheInclude extends _isd.IncludeObject {
  PhotoCacheInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<int?> get table => PhotoCache.t;
}

class PhotoCacheIncludeList extends _isd.IncludeList {
  PhotoCacheIncludeList._({
    _isd.WhereExpressionBuilder<PhotoCacheTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PhotoCache.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<int?> get table => PhotoCache.t;
}

class PhotoCacheRepository {
  const PhotoCacheRepository._();

  /// Returns a list of [PhotoCache]s matching the given query parameters.
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
  Future<List<PhotoCache>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<PhotoCacheTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<PhotoCacheTable>? orderBy,
    _isd.OrderByListBuilder<PhotoCacheTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PhotoCache>(
      where: where?.call(PhotoCache.t),
      orderBy: orderBy?.call(PhotoCache.t),
      orderByList: orderByList?.call(PhotoCache.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [PhotoCache]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `PhotoCache.t`.
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
  _ida.Stream<List<PhotoCache>> watch(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<PhotoCacheTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<PhotoCacheTable>? orderBy,
    _isd.OrderByListBuilder<PhotoCacheTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_isd.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<PhotoCache>(
      where: where?.call(PhotoCache.t),
      orderBy: orderBy?.call(PhotoCache.t),
      orderByList: orderByList?.call(PhotoCache.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [PhotoCache] matching the given query parameters.
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
  Future<PhotoCache?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<PhotoCacheTable>? where,
    int? offset,
    _isd.OrderByBuilder<PhotoCacheTable>? orderBy,
    _isd.OrderByListBuilder<PhotoCacheTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PhotoCache>(
      where: where?.call(PhotoCache.t),
      orderBy: orderBy?.call(PhotoCache.t),
      orderByList: orderByList?.call(PhotoCache.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PhotoCache] by its [id] or null if no such row exists.
  Future<PhotoCache?> findById(
    _isd.DatabaseSession session,
    int id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PhotoCache>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PhotoCache]s in the list and returns the inserted rows.
  ///
  /// The returned [PhotoCache]s will have their `id` fields set.
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
  Future<List<PhotoCache>> insert(
    _isd.DatabaseSession session,
    List<PhotoCache> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PhotoCache>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PhotoCache] and returns the inserted row.
  ///
  /// The returned [PhotoCache] will have its `id` field set.
  Future<PhotoCache> insertRow(
    _isd.DatabaseSession session,
    PhotoCache row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<PhotoCache>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PhotoCache]s in the list and returns the resulting rows.
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
  /// The returned [PhotoCache]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PhotoCache>> upsert(
    _isd.DatabaseSession session,
    List<PhotoCache> rows, {
    required _isd.ColumnSelections<PhotoCacheTable> conflictColumns,
    _isd.ColumnSelections<PhotoCacheTable>? updateColumns,
    _isd.WhereExpressionBuilder<PhotoCacheTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PhotoCache>(
      rows,
      conflictColumns: conflictColumns(PhotoCache.t),
      updateColumns: updateColumns?.call(PhotoCache.t),
      updateWhere: updateWhere?.call(PhotoCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PhotoCache] and returns the resulting row.
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
  /// The returned [PhotoCache] will have its `id` field set.
  Future<PhotoCache?> upsertRow(
    _isd.DatabaseSession session,
    PhotoCache row, {
    required _isd.ColumnSelections<PhotoCacheTable> conflictColumns,
    _isd.ColumnSelections<PhotoCacheTable>? updateColumns,
    _isd.WhereExpressionBuilder<PhotoCacheTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PhotoCache>(
      row,
      conflictColumns: conflictColumns(PhotoCache.t),
      updateColumns: updateColumns?.call(PhotoCache.t),
      updateWhere: updateWhere?.call(PhotoCache.t),
      transaction: transaction,
    );
  }

  /// Updates all [PhotoCache]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PhotoCache>> update(
    _isd.DatabaseSession session,
    List<PhotoCache> rows, {
    _isd.ColumnSelections<PhotoCacheTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PhotoCache>(
      rows,
      columns: columns?.call(PhotoCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PhotoCache]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PhotoCache> updateRow(
    _isd.DatabaseSession session,
    PhotoCache row, {
    _isd.ColumnSelections<PhotoCacheTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<PhotoCache>(
      row,
      columns: columns?.call(PhotoCache.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PhotoCache] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PhotoCache?> updateById(
    _isd.DatabaseSession session,
    int id, {
    required _isd.ColumnValueListBuilder<PhotoCacheUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<PhotoCache>(
      id,
      columnValues: columnValues(PhotoCache.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PhotoCache]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PhotoCache>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<PhotoCacheUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<PhotoCacheTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<PhotoCacheTable>? orderBy,
    _isd.OrderByListBuilder<PhotoCacheTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PhotoCache>(
      columnValues: columnValues(PhotoCache.t.updateTable),
      where: where(PhotoCache.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PhotoCache.t),
      orderByList: orderByList?.call(PhotoCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PhotoCache]s in the list and returns the deleted rows.
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
  Future<List<PhotoCache>> delete(
    _isd.DatabaseSession session,
    List<PhotoCache> rows, {
    _isd.OrderByBuilder<PhotoCacheTable>? orderBy,
    _isd.OrderByListBuilder<PhotoCacheTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PhotoCache>(
      rows,
      orderBy: orderBy?.call(PhotoCache.t),
      orderByList: orderByList?.call(PhotoCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PhotoCache].
  Future<PhotoCache> deleteRow(
    _isd.DatabaseSession session,
    PhotoCache row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PhotoCache>(
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
  Future<List<PhotoCache>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<PhotoCacheTable> where,
    _isd.OrderByBuilder<PhotoCacheTable>? orderBy,
    _isd.OrderByListBuilder<PhotoCacheTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PhotoCache>(
      where: where(PhotoCache.t),
      orderBy: orderBy?.call(PhotoCache.t),
      orderByList: orderByList?.call(PhotoCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<PhotoCacheTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<PhotoCache>(
      where: where?.call(PhotoCache.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PhotoCache] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<PhotoCacheTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PhotoCache>(
      where: where(PhotoCache.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
