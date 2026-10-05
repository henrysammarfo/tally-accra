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

/// Idempotent ledger of client offline mutations already accepted.
abstract class SyncedMutation
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  SyncedMutation._({
    this.id,
    required this.organizationId,
    required this.clientMutationId,
    this.depositId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory SyncedMutation({
    _is.UuidValue? id,
    required _is.UuidValue organizationId,
    required String clientMutationId,
    _is.UuidValue? depositId,
    DateTime? createdAt,
  }) = _SyncedMutationImpl;

  factory SyncedMutation.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncedMutation(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      clientMutationId: jsonSerialization['clientMutationId'] as String,
      depositId: jsonSerialization['depositId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['depositId']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = SyncedMutationTable();

  static const db = SyncedMutationRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue organizationId;

  String clientMutationId;

  _is.UuidValue? depositId;

  DateTime createdAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [SyncedMutation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SyncedMutation copyWith({
    _is.UuidValue? id,
    _is.UuidValue? organizationId,
    String? clientMutationId,
    _is.UuidValue? depositId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncedMutation',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'clientMutationId': clientMutationId,
      if (depositId != null) 'depositId': depositId?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncedMutation',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'clientMutationId': clientMutationId,
      if (depositId != null) 'depositId': depositId?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static SyncedMutationInclude include() {
    return SyncedMutationInclude._();
  }

  static SyncedMutationIncludeList includeList({
    _is.WhereExpressionBuilder<SyncedMutationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedMutationTable>? orderBy,
    _is.OrderByListBuilder<SyncedMutationTable>? orderByList,
    SyncedMutationInclude? include,
  }) {
    return SyncedMutationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyncedMutation.t),
      orderByList: orderByList?.call(SyncedMutation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyncedMutationImpl extends SyncedMutation {
  _SyncedMutationImpl({
    _is.UuidValue? id,
    required _is.UuidValue organizationId,
    required String clientMutationId,
    _is.UuidValue? depositId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         clientMutationId: clientMutationId,
         depositId: depositId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SyncedMutation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SyncedMutation copyWith({
    Object? id = _Undefined,
    _is.UuidValue? organizationId,
    String? clientMutationId,
    Object? depositId = _Undefined,
    DateTime? createdAt,
  }) {
    return SyncedMutation(
      id: id is _is.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      clientMutationId: clientMutationId ?? this.clientMutationId,
      depositId: depositId is _is.UuidValue? ? depositId : this.depositId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SyncedMutationUpdateTable extends _is.UpdateTable<SyncedMutationTable> {
  SyncedMutationUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> organizationId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.organizationId,
    value,
  );

  _is.ColumnValue<String, String> clientMutationId(String value) =>
      _is.ColumnValue(
        table.clientMutationId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> depositId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.depositId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class SyncedMutationTable extends _is.Table<_is.UuidValue?> {
  SyncedMutationTable({super.tableRelation})
    : super(tableName: 'synced_mutation') {
    updateTable = SyncedMutationUpdateTable(this);
    organizationId = _is.ColumnUuid(
      'organizationId',
      this,
    );
    clientMutationId = _is.ColumnString(
      'clientMutationId',
      this,
    );
    depositId = _is.ColumnUuid(
      'depositId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final SyncedMutationUpdateTable updateTable;

  late final _is.ColumnUuid organizationId;

  late final _is.ColumnString clientMutationId;

  late final _is.ColumnUuid depositId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    organizationId,
    clientMutationId,
    depositId,
    createdAt,
  ];
}

class SyncedMutationInclude extends _is.IncludeObject {
  SyncedMutationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => SyncedMutation.t;
}

class SyncedMutationIncludeList extends _is.IncludeList {
  SyncedMutationIncludeList._({
    _is.WhereExpressionBuilder<SyncedMutationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SyncedMutation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => SyncedMutation.t;
}

class SyncedMutationRepository {
  const SyncedMutationRepository._();

  /// Returns a list of [SyncedMutation]s matching the given query parameters.
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
  Future<List<SyncedMutation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedMutationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedMutationTable>? orderBy,
    _is.OrderByListBuilder<SyncedMutationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SyncedMutation>(
      where: where?.call(SyncedMutation.t),
      orderBy: orderBy?.call(SyncedMutation.t),
      orderByList: orderByList?.call(SyncedMutation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SyncedMutation] matching the given query parameters.
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
  Future<SyncedMutation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedMutationTable>? where,
    int? offset,
    _is.OrderByBuilder<SyncedMutationTable>? orderBy,
    _is.OrderByListBuilder<SyncedMutationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SyncedMutation>(
      where: where?.call(SyncedMutation.t),
      orderBy: orderBy?.call(SyncedMutation.t),
      orderByList: orderByList?.call(SyncedMutation.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SyncedMutation] by its [id] or null if no such row exists.
  Future<SyncedMutation?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SyncedMutation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SyncedMutation]s in the list and returns the inserted rows.
  ///
  /// The returned [SyncedMutation]s will have their `id` fields set.
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
  Future<List<SyncedMutation>> insert(
    _is.DatabaseSession session,
    List<SyncedMutation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SyncedMutation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SyncedMutation] and returns the inserted row.
  ///
  /// The returned [SyncedMutation] will have its `id` field set.
  Future<SyncedMutation> insertRow(
    _is.DatabaseSession session,
    SyncedMutation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SyncedMutation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SyncedMutation]s in the list and returns the resulting rows.
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
  /// The returned [SyncedMutation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedMutation>> upsert(
    _is.DatabaseSession session,
    List<SyncedMutation> rows, {
    required _is.ColumnSelections<SyncedMutationTable> conflictColumns,
    _is.ColumnSelections<SyncedMutationTable>? updateColumns,
    _is.WhereExpressionBuilder<SyncedMutationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SyncedMutation>(
      rows,
      conflictColumns: conflictColumns(SyncedMutation.t),
      updateColumns: updateColumns?.call(SyncedMutation.t),
      updateWhere: updateWhere?.call(SyncedMutation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SyncedMutation] and returns the resulting row.
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
  /// The returned [SyncedMutation] will have its `id` field set.
  Future<SyncedMutation?> upsertRow(
    _is.DatabaseSession session,
    SyncedMutation row, {
    required _is.ColumnSelections<SyncedMutationTable> conflictColumns,
    _is.ColumnSelections<SyncedMutationTable>? updateColumns,
    _is.WhereExpressionBuilder<SyncedMutationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SyncedMutation>(
      row,
      conflictColumns: conflictColumns(SyncedMutation.t),
      updateColumns: updateColumns?.call(SyncedMutation.t),
      updateWhere: updateWhere?.call(SyncedMutation.t),
      transaction: transaction,
    );
  }

  /// Updates all [SyncedMutation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedMutation>> update(
    _is.DatabaseSession session,
    List<SyncedMutation> rows, {
    _is.ColumnSelections<SyncedMutationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SyncedMutation>(
      rows,
      columns: columns?.call(SyncedMutation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SyncedMutation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SyncedMutation> updateRow(
    _is.DatabaseSession session,
    SyncedMutation row, {
    _is.ColumnSelections<SyncedMutationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SyncedMutation>(
      row,
      columns: columns?.call(SyncedMutation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SyncedMutation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SyncedMutation?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<SyncedMutationUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SyncedMutation>(
      id,
      columnValues: columnValues(SyncedMutation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SyncedMutation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedMutation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SyncedMutationUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SyncedMutationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedMutationTable>? orderBy,
    _is.OrderByListBuilder<SyncedMutationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SyncedMutation>(
      columnValues: columnValues(SyncedMutation.t.updateTable),
      where: where(SyncedMutation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyncedMutation.t),
      orderByList: orderByList?.call(SyncedMutation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SyncedMutation]s in the list and returns the deleted rows.
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
  Future<List<SyncedMutation>> delete(
    _is.DatabaseSession session,
    List<SyncedMutation> rows, {
    _is.OrderByBuilder<SyncedMutationTable>? orderBy,
    _is.OrderByListBuilder<SyncedMutationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SyncedMutation>(
      rows,
      orderBy: orderBy?.call(SyncedMutation.t),
      orderByList: orderByList?.call(SyncedMutation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SyncedMutation].
  Future<SyncedMutation> deleteRow(
    _is.DatabaseSession session,
    SyncedMutation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SyncedMutation>(
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
  Future<List<SyncedMutation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyncedMutationTable> where,
    _is.OrderByBuilder<SyncedMutationTable>? orderBy,
    _is.OrderByListBuilder<SyncedMutationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SyncedMutation>(
      where: where(SyncedMutation.t),
      orderBy: orderBy?.call(SyncedMutation.t),
      orderByList: orderByList?.call(SyncedMutation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedMutationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SyncedMutation>(
      where: where?.call(SyncedMutation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SyncedMutation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyncedMutationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SyncedMutation>(
      where: where(SyncedMutation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
