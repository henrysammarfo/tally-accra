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
import 'package:serverpod/serverpod.dart' as _is;

abstract class ShiftClose
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  ShiftClose._({
    this.id,
    required this.organizationId,
    bool? closed,
    this.closedAt,
    this.notes,
    this.expectedTotal,
    this.countedTotal,
  }) : closed = closed ?? false;

  factory ShiftClose({
    _is.UuidValue? id,
    required _is.UuidValue organizationId,
    bool? closed,
    DateTime? closedAt,
    String? notes,
    double? expectedTotal,
    double? countedTotal,
  }) = _ShiftCloseImpl;

  factory ShiftClose.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShiftClose(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      closed: jsonSerialization['closed'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['closed']),
      closedAt: jsonSerialization['closedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['closedAt']),
      notes: jsonSerialization['notes'] as String?,
      expectedTotal: (jsonSerialization['expectedTotal'] as num?)?.toDouble(),
      countedTotal: (jsonSerialization['countedTotal'] as num?)?.toDouble(),
    );
  }

  static final t = ShiftCloseTable();

  static const db = ShiftCloseRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue organizationId;

  bool closed;

  DateTime? closedAt;

  String? notes;

  double? expectedTotal;

  double? countedTotal;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ShiftClose]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ShiftClose copyWith({
    _is.UuidValue? id,
    _is.UuidValue? organizationId,
    bool? closed,
    DateTime? closedAt,
    String? notes,
    double? expectedTotal,
    double? countedTotal,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShiftClose',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'closed': closed,
      if (closedAt != null) 'closedAt': closedAt?.toJson(),
      if (notes != null) 'notes': notes,
      if (expectedTotal != null) 'expectedTotal': expectedTotal,
      if (countedTotal != null) 'countedTotal': countedTotal,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ShiftClose',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'closed': closed,
      if (closedAt != null) 'closedAt': closedAt?.toJson(),
      if (notes != null) 'notes': notes,
      if (expectedTotal != null) 'expectedTotal': expectedTotal,
      if (countedTotal != null) 'countedTotal': countedTotal,
    };
  }

  static ShiftCloseInclude include() {
    return ShiftCloseInclude._();
  }

  static ShiftCloseIncludeList includeList({
    _is.WhereExpressionBuilder<ShiftCloseTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShiftCloseTable>? orderBy,
    _is.OrderByListBuilder<ShiftCloseTable>? orderByList,
    ShiftCloseInclude? include,
  }) {
    return ShiftCloseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ShiftClose.t),
      orderByList: orderByList?.call(ShiftClose.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShiftCloseImpl extends ShiftClose {
  _ShiftCloseImpl({
    _is.UuidValue? id,
    required _is.UuidValue organizationId,
    bool? closed,
    DateTime? closedAt,
    String? notes,
    double? expectedTotal,
    double? countedTotal,
  }) : super._(
         id: id,
         organizationId: organizationId,
         closed: closed,
         closedAt: closedAt,
         notes: notes,
         expectedTotal: expectedTotal,
         countedTotal: countedTotal,
       );

  /// Returns a shallow copy of this [ShiftClose]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ShiftClose copyWith({
    Object? id = _Undefined,
    _is.UuidValue? organizationId,
    bool? closed,
    Object? closedAt = _Undefined,
    Object? notes = _Undefined,
    Object? expectedTotal = _Undefined,
    Object? countedTotal = _Undefined,
  }) {
    return ShiftClose(
      id: id is _is.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      closed: closed ?? this.closed,
      closedAt: closedAt is DateTime? ? closedAt : this.closedAt,
      notes: notes is String? ? notes : this.notes,
      expectedTotal: expectedTotal is double?
          ? expectedTotal
          : this.expectedTotal,
      countedTotal: countedTotal is double? ? countedTotal : this.countedTotal,
    );
  }
}

class ShiftCloseUpdateTable extends _is.UpdateTable<ShiftCloseTable> {
  ShiftCloseUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> organizationId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.organizationId,
    value,
  );

  _is.ColumnValue<bool, bool> closed(bool value) => _is.ColumnValue(
    table.closed,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> closedAt(DateTime? value) =>
      _is.ColumnValue(
        table.closedAt,
        value,
      );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );

  _is.ColumnValue<double, double> expectedTotal(double? value) =>
      _is.ColumnValue(
        table.expectedTotal,
        value,
      );

  _is.ColumnValue<double, double> countedTotal(double? value) =>
      _is.ColumnValue(
        table.countedTotal,
        value,
      );
}

class ShiftCloseTable extends _is.Table<_is.UuidValue?> {
  ShiftCloseTable({super.tableRelation}) : super(tableName: 'shift_close') {
    updateTable = ShiftCloseUpdateTable(this);
    organizationId = _is.ColumnUuid(
      'organizationId',
      this,
    );
    closed = _is.ColumnBool(
      'closed',
      this,
      hasDefault: true,
    );
    closedAt = _is.ColumnDateTime(
      'closedAt',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
    expectedTotal = _is.ColumnDouble(
      'expectedTotal',
      this,
    );
    countedTotal = _is.ColumnDouble(
      'countedTotal',
      this,
    );
  }

  late final ShiftCloseUpdateTable updateTable;

  late final _is.ColumnUuid organizationId;

  late final _is.ColumnBool closed;

  late final _is.ColumnDateTime closedAt;

  late final _is.ColumnString notes;

  late final _is.ColumnDouble expectedTotal;

  late final _is.ColumnDouble countedTotal;

  @override
  List<_is.Column> get columns => [
    id,
    organizationId,
    closed,
    closedAt,
    notes,
    expectedTotal,
    countedTotal,
  ];
}

class ShiftCloseInclude extends _is.IncludeObject {
  ShiftCloseInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => ShiftClose.t;
}

class ShiftCloseIncludeList extends _is.IncludeList {
  ShiftCloseIncludeList._({
    _is.WhereExpressionBuilder<ShiftCloseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ShiftClose.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => ShiftClose.t;
}

class ShiftCloseRepository {
  const ShiftCloseRepository._();

  /// Returns a list of [ShiftClose]s matching the given query parameters.
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
  Future<List<ShiftClose>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShiftCloseTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShiftCloseTable>? orderBy,
    _is.OrderByListBuilder<ShiftCloseTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ShiftClose>(
      where: where?.call(ShiftClose.t),
      orderBy: orderBy?.call(ShiftClose.t),
      orderByList: orderByList?.call(ShiftClose.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ShiftClose] matching the given query parameters.
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
  Future<ShiftClose?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShiftCloseTable>? where,
    int? offset,
    _is.OrderByBuilder<ShiftCloseTable>? orderBy,
    _is.OrderByListBuilder<ShiftCloseTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ShiftClose>(
      where: where?.call(ShiftClose.t),
      orderBy: orderBy?.call(ShiftClose.t),
      orderByList: orderByList?.call(ShiftClose.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ShiftClose] by its [id] or null if no such row exists.
  Future<ShiftClose?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ShiftClose>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ShiftClose]s in the list and returns the inserted rows.
  ///
  /// The returned [ShiftClose]s will have their `id` fields set.
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
  Future<List<ShiftClose>> insert(
    _is.DatabaseSession session,
    List<ShiftClose> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ShiftClose>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ShiftClose] and returns the inserted row.
  ///
  /// The returned [ShiftClose] will have its `id` field set.
  Future<ShiftClose> insertRow(
    _is.DatabaseSession session,
    ShiftClose row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ShiftClose>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ShiftClose]s in the list and returns the resulting rows.
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
  /// The returned [ShiftClose]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ShiftClose>> upsert(
    _is.DatabaseSession session,
    List<ShiftClose> rows, {
    required _is.ColumnSelections<ShiftCloseTable> conflictColumns,
    _is.ColumnSelections<ShiftCloseTable>? updateColumns,
    _is.WhereExpressionBuilder<ShiftCloseTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ShiftClose>(
      rows,
      conflictColumns: conflictColumns(ShiftClose.t),
      updateColumns: updateColumns?.call(ShiftClose.t),
      updateWhere: updateWhere?.call(ShiftClose.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ShiftClose] and returns the resulting row.
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
  /// The returned [ShiftClose] will have its `id` field set.
  Future<ShiftClose?> upsertRow(
    _is.DatabaseSession session,
    ShiftClose row, {
    required _is.ColumnSelections<ShiftCloseTable> conflictColumns,
    _is.ColumnSelections<ShiftCloseTable>? updateColumns,
    _is.WhereExpressionBuilder<ShiftCloseTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ShiftClose>(
      row,
      conflictColumns: conflictColumns(ShiftClose.t),
      updateColumns: updateColumns?.call(ShiftClose.t),
      updateWhere: updateWhere?.call(ShiftClose.t),
      transaction: transaction,
    );
  }

  /// Updates all [ShiftClose]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ShiftClose>> update(
    _is.DatabaseSession session,
    List<ShiftClose> rows, {
    _is.ColumnSelections<ShiftCloseTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ShiftClose>(
      rows,
      columns: columns?.call(ShiftClose.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ShiftClose]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ShiftClose> updateRow(
    _is.DatabaseSession session,
    ShiftClose row, {
    _is.ColumnSelections<ShiftCloseTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ShiftClose>(
      row,
      columns: columns?.call(ShiftClose.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ShiftClose] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ShiftClose?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<ShiftCloseUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ShiftClose>(
      id,
      columnValues: columnValues(ShiftClose.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ShiftClose]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ShiftClose>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ShiftCloseUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ShiftCloseTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShiftCloseTable>? orderBy,
    _is.OrderByListBuilder<ShiftCloseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ShiftClose>(
      columnValues: columnValues(ShiftClose.t.updateTable),
      where: where(ShiftClose.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ShiftClose.t),
      orderByList: orderByList?.call(ShiftClose.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ShiftClose]s in the list and returns the deleted rows.
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
  Future<List<ShiftClose>> delete(
    _is.DatabaseSession session,
    List<ShiftClose> rows, {
    _is.OrderByBuilder<ShiftCloseTable>? orderBy,
    _is.OrderByListBuilder<ShiftCloseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ShiftClose>(
      rows,
      orderBy: orderBy?.call(ShiftClose.t),
      orderByList: orderByList?.call(ShiftClose.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ShiftClose].
  Future<ShiftClose> deleteRow(
    _is.DatabaseSession session,
    ShiftClose row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ShiftClose>(
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
  Future<List<ShiftClose>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ShiftCloseTable> where,
    _is.OrderByBuilder<ShiftCloseTable>? orderBy,
    _is.OrderByListBuilder<ShiftCloseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ShiftClose>(
      where: where(ShiftClose.t),
      orderBy: orderBy?.call(ShiftClose.t),
      orderByList: orderByList?.call(ShiftClose.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShiftCloseTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ShiftClose>(
      where: where?.call(ShiftClose.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ShiftClose] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ShiftCloseTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ShiftClose>(
      where: where(ShiftClose.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
