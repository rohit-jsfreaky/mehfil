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

/// The server's proof that a photo arrived: the file is in private storage and
/// its hash matched. Written once per shot, stamped with server time.
abstract class ShotReceipt
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ShotReceipt._({
    this.id,
    required this.shotId,
    required this.eventId,
    required this.rollId,
    required this.guestId,
    required this.storagePath,
    required this.thumbPath,
    required this.sha256,
    required this.sizeBytes,
    required this.width,
    required this.height,
    required this.takenAt,
    required this.receivedAt,
    this.removedAt,
  });

  factory ShotReceipt({
    int? id,
    required _is.UuidValue shotId,
    required int eventId,
    required int rollId,
    required int guestId,
    required String storagePath,
    required String thumbPath,
    required String sha256,
    required int sizeBytes,
    required int width,
    required int height,
    required DateTime takenAt,
    required DateTime receivedAt,
    DateTime? removedAt,
  }) = _ShotReceiptImpl;

  factory ShotReceipt.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShotReceipt(
      id: jsonSerialization['id'] as int?,
      shotId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['shotId']),
      eventId: jsonSerialization['eventId'] as int,
      rollId: jsonSerialization['rollId'] as int,
      guestId: jsonSerialization['guestId'] as int,
      storagePath: jsonSerialization['storagePath'] as String,
      thumbPath: jsonSerialization['thumbPath'] as String,
      sha256: jsonSerialization['sha256'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      width: jsonSerialization['width'] as int,
      height: jsonSerialization['height'] as int,
      takenAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['takenAt']),
      receivedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
      removedAt: jsonSerialization['removedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['removedAt']),
    );
  }

  static final t = ShotReceiptTable();

  static const db = ShotReceiptRepository._();

  @override
  int? id;

  _is.UuidValue shotId;

  int eventId;

  int rollId;

  int guestId;

  String storagePath;

  String thumbPath;

  String sha256;

  int sizeBytes;

  int width;

  int height;

  /// What the phone said. Shown as the phone's claim, never trusted.
  DateTime takenAt;

  /// Server time when the file and row were both stored.
  DateTime receivedAt;

  /// Set when the host removes the photo. The receipt stays as evidence that
  /// it arrived; the file and its album copy are deleted.
  DateTime? removedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ShotReceipt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ShotReceipt copyWith({
    int? id,
    _is.UuidValue? shotId,
    int? eventId,
    int? rollId,
    int? guestId,
    String? storagePath,
    String? thumbPath,
    String? sha256,
    int? sizeBytes,
    int? width,
    int? height,
    DateTime? takenAt,
    DateTime? receivedAt,
    DateTime? removedAt = const _is.$UndefinedDateTime(),
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShotReceipt',
      if (id != null) 'id': id,
      'shotId': shotId.toJson(),
      'eventId': eventId,
      'rollId': rollId,
      'guestId': guestId,
      'storagePath': storagePath,
      'thumbPath': thumbPath,
      'sha256': sha256,
      'sizeBytes': sizeBytes,
      'width': width,
      'height': height,
      'takenAt': takenAt.toJson(),
      'receivedAt': receivedAt.toJson(),
      if (removedAt != null) 'removedAt': removedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ShotReceiptInclude include() {
    return ShotReceiptInclude._();
  }

  static ShotReceiptIncludeList includeList({
    _is.WhereExpressionBuilder<ShotReceiptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShotReceiptTable>? orderBy,
    _is.OrderByListBuilder<ShotReceiptTable>? orderByList,
    ShotReceiptInclude? include,
  }) {
    return ShotReceiptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ShotReceipt.t),
      orderByList: orderByList?.call(ShotReceipt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShotReceiptImpl extends ShotReceipt {
  _ShotReceiptImpl({
    int? id,
    required _is.UuidValue shotId,
    required int eventId,
    required int rollId,
    required int guestId,
    required String storagePath,
    required String thumbPath,
    required String sha256,
    required int sizeBytes,
    required int width,
    required int height,
    required DateTime takenAt,
    required DateTime receivedAt,
    DateTime? removedAt,
  }) : super._(
         id: id,
         shotId: shotId,
         eventId: eventId,
         rollId: rollId,
         guestId: guestId,
         storagePath: storagePath,
         thumbPath: thumbPath,
         sha256: sha256,
         sizeBytes: sizeBytes,
         width: width,
         height: height,
         takenAt: takenAt,
         receivedAt: receivedAt,
         removedAt: removedAt,
       );

  /// Returns a shallow copy of this [ShotReceipt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ShotReceipt copyWith({
    Object? id = _Undefined,
    _is.UuidValue? shotId,
    int? eventId,
    int? rollId,
    int? guestId,
    String? storagePath,
    String? thumbPath,
    String? sha256,
    int? sizeBytes,
    int? width,
    int? height,
    DateTime? takenAt,
    DateTime? receivedAt,
    DateTime? removedAt = const _is.$UndefinedDateTime(),
  }) {
    return ShotReceipt(
      id: id is int? ? id : this.id,
      shotId: shotId ?? this.shotId,
      eventId: eventId ?? this.eventId,
      rollId: rollId ?? this.rollId,
      guestId: guestId ?? this.guestId,
      storagePath: storagePath ?? this.storagePath,
      thumbPath: thumbPath ?? this.thumbPath,
      sha256: sha256 ?? this.sha256,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      width: width ?? this.width,
      height: height ?? this.height,
      takenAt: takenAt ?? this.takenAt,
      receivedAt: receivedAt ?? this.receivedAt,
      removedAt: removedAt is _is.UndefinedSentinel
          ? this.removedAt
          : removedAt,
    );
  }
}

class ShotReceiptUpdateTable extends _is.UpdateTable<ShotReceiptTable> {
  ShotReceiptUpdateTable(super.table);

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

  _is.ColumnValue<int, int> guestId(int value) => _is.ColumnValue(
    table.guestId,
    value,
  );

  _is.ColumnValue<String, String> storagePath(String value) => _is.ColumnValue(
    table.storagePath,
    value,
  );

  _is.ColumnValue<String, String> thumbPath(String value) => _is.ColumnValue(
    table.thumbPath,
    value,
  );

  _is.ColumnValue<String, String> sha256(String value) => _is.ColumnValue(
    table.sha256,
    value,
  );

  _is.ColumnValue<int, int> sizeBytes(int value) => _is.ColumnValue(
    table.sizeBytes,
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

  _is.ColumnValue<DateTime, DateTime> removedAt(DateTime? value) =>
      _is.ColumnValue(
        table.removedAt,
        value,
      );
}

class ShotReceiptTable extends _is.Table<int?> {
  ShotReceiptTable({super.tableRelation}) : super(tableName: 'shot_receipt') {
    updateTable = ShotReceiptUpdateTable(this);
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
    guestId = _is.ColumnInt(
      'guestId',
      this,
    );
    storagePath = _is.ColumnString(
      'storagePath',
      this,
    );
    thumbPath = _is.ColumnString(
      'thumbPath',
      this,
    );
    sha256 = _is.ColumnString(
      'sha256',
      this,
    );
    sizeBytes = _is.ColumnInt(
      'sizeBytes',
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
    takenAt = _is.ColumnDateTime(
      'takenAt',
      this,
    );
    receivedAt = _is.ColumnDateTime(
      'receivedAt',
      this,
    );
    removedAt = _is.ColumnDateTime(
      'removedAt',
      this,
    );
  }

  late final ShotReceiptUpdateTable updateTable;

  late final _is.ColumnUuid shotId;

  late final _is.ColumnInt eventId;

  late final _is.ColumnInt rollId;

  late final _is.ColumnInt guestId;

  late final _is.ColumnString storagePath;

  late final _is.ColumnString thumbPath;

  late final _is.ColumnString sha256;

  late final _is.ColumnInt sizeBytes;

  late final _is.ColumnInt width;

  late final _is.ColumnInt height;

  /// What the phone said. Shown as the phone's claim, never trusted.
  late final _is.ColumnDateTime takenAt;

  /// Server time when the file and row were both stored.
  late final _is.ColumnDateTime receivedAt;

  /// Set when the host removes the photo. The receipt stays as evidence that
  /// it arrived; the file and its album copy are deleted.
  late final _is.ColumnDateTime removedAt;

  @override
  List<_is.Column> get columns => [
    id,
    shotId,
    eventId,
    rollId,
    guestId,
    storagePath,
    thumbPath,
    sha256,
    sizeBytes,
    width,
    height,
    takenAt,
    receivedAt,
    removedAt,
  ];
}

class ShotReceiptInclude extends _is.IncludeObject {
  ShotReceiptInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ShotReceipt.t;
}

class ShotReceiptIncludeList extends _is.IncludeList {
  ShotReceiptIncludeList._({
    _is.WhereExpressionBuilder<ShotReceiptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ShotReceipt.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ShotReceipt.t;
}

class ShotReceiptRepository {
  const ShotReceiptRepository._();

  /// Returns a list of [ShotReceipt]s matching the given query parameters.
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
  Future<List<ShotReceipt>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShotReceiptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShotReceiptTable>? orderBy,
    _is.OrderByListBuilder<ShotReceiptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ShotReceipt>(
      where: where?.call(ShotReceipt.t),
      orderBy: orderBy?.call(ShotReceipt.t),
      orderByList: orderByList?.call(ShotReceipt.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [ShotReceipt]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `ShotReceipt.t`.
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
  _ida.Stream<List<ShotReceipt>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShotReceiptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShotReceiptTable>? orderBy,
    _is.OrderByListBuilder<ShotReceiptTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<ShotReceipt>(
      where: where?.call(ShotReceipt.t),
      orderBy: orderBy?.call(ShotReceipt.t),
      orderByList: orderByList?.call(ShotReceipt.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [ShotReceipt] matching the given query parameters.
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
  Future<ShotReceipt?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShotReceiptTable>? where,
    int? offset,
    _is.OrderByBuilder<ShotReceiptTable>? orderBy,
    _is.OrderByListBuilder<ShotReceiptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ShotReceipt>(
      where: where?.call(ShotReceipt.t),
      orderBy: orderBy?.call(ShotReceipt.t),
      orderByList: orderByList?.call(ShotReceipt.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ShotReceipt] by its [id] or null if no such row exists.
  Future<ShotReceipt?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ShotReceipt>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ShotReceipt]s in the list and returns the inserted rows.
  ///
  /// The returned [ShotReceipt]s will have their `id` fields set.
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
  Future<List<ShotReceipt>> insert(
    _is.DatabaseSession session,
    List<ShotReceipt> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ShotReceipt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ShotReceipt] and returns the inserted row.
  ///
  /// The returned [ShotReceipt] will have its `id` field set.
  Future<ShotReceipt> insertRow(
    _is.DatabaseSession session,
    ShotReceipt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ShotReceipt>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ShotReceipt]s in the list and returns the resulting rows.
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
  /// The returned [ShotReceipt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ShotReceipt>> upsert(
    _is.DatabaseSession session,
    List<ShotReceipt> rows, {
    required _is.ColumnSelections<ShotReceiptTable> conflictColumns,
    _is.ColumnSelections<ShotReceiptTable>? updateColumns,
    _is.WhereExpressionBuilder<ShotReceiptTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ShotReceipt>(
      rows,
      conflictColumns: conflictColumns(ShotReceipt.t),
      updateColumns: updateColumns?.call(ShotReceipt.t),
      updateWhere: updateWhere?.call(ShotReceipt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ShotReceipt] and returns the resulting row.
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
  /// The returned [ShotReceipt] will have its `id` field set.
  Future<ShotReceipt?> upsertRow(
    _is.DatabaseSession session,
    ShotReceipt row, {
    required _is.ColumnSelections<ShotReceiptTable> conflictColumns,
    _is.ColumnSelections<ShotReceiptTable>? updateColumns,
    _is.WhereExpressionBuilder<ShotReceiptTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ShotReceipt>(
      row,
      conflictColumns: conflictColumns(ShotReceipt.t),
      updateColumns: updateColumns?.call(ShotReceipt.t),
      updateWhere: updateWhere?.call(ShotReceipt.t),
      transaction: transaction,
    );
  }

  /// Updates all [ShotReceipt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ShotReceipt>> update(
    _is.DatabaseSession session,
    List<ShotReceipt> rows, {
    _is.ColumnSelections<ShotReceiptTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ShotReceipt>(
      rows,
      columns: columns?.call(ShotReceipt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ShotReceipt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ShotReceipt> updateRow(
    _is.DatabaseSession session,
    ShotReceipt row, {
    _is.ColumnSelections<ShotReceiptTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ShotReceipt>(
      row,
      columns: columns?.call(ShotReceipt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ShotReceipt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ShotReceipt?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ShotReceiptUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ShotReceipt>(
      id,
      columnValues: columnValues(ShotReceipt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ShotReceipt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ShotReceipt>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ShotReceiptUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ShotReceiptTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShotReceiptTable>? orderBy,
    _is.OrderByListBuilder<ShotReceiptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ShotReceipt>(
      columnValues: columnValues(ShotReceipt.t.updateTable),
      where: where(ShotReceipt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ShotReceipt.t),
      orderByList: orderByList?.call(ShotReceipt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ShotReceipt]s in the list and returns the deleted rows.
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
  Future<List<ShotReceipt>> delete(
    _is.DatabaseSession session,
    List<ShotReceipt> rows, {
    _is.OrderByBuilder<ShotReceiptTable>? orderBy,
    _is.OrderByListBuilder<ShotReceiptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ShotReceipt>(
      rows,
      orderBy: orderBy?.call(ShotReceipt.t),
      orderByList: orderByList?.call(ShotReceipt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ShotReceipt].
  Future<ShotReceipt> deleteRow(
    _is.DatabaseSession session,
    ShotReceipt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ShotReceipt>(
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
  Future<List<ShotReceipt>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ShotReceiptTable> where,
    _is.OrderByBuilder<ShotReceiptTable>? orderBy,
    _is.OrderByListBuilder<ShotReceiptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ShotReceipt>(
      where: where(ShotReceipt.t),
      orderBy: orderBy?.call(ShotReceipt.t),
      orderByList: orderByList?.call(ShotReceipt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShotReceiptTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ShotReceipt>(
      where: where?.call(ShotReceipt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ShotReceipt] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ShotReceiptTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ShotReceipt>(
      where: where(ShotReceipt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
