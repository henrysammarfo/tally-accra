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
import '../till/currency_code.dart' as _i3o61vxh;
import '../till/payment_method.dart' as _ie3b7ann;

abstract class Deposit
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  Deposit._({
    this.id,
    required this.organizationId,
    required this.roomId,
    required this.guestName,
    required this.guestPhone,
    required this.nights,
    required this.amount,
    required this.currency,
    required this.method,
    required this.receptionistName,
    required this.receiptCode,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Deposit({
    _is.UuidValue? id,
    required _is.UuidValue organizationId,
    required _is.UuidValue roomId,
    required String guestName,
    required String guestPhone,
    required int nights,
    required double amount,
    required _i3o61vxh.CurrencyCode currency,
    required _ie3b7ann.PaymentMethod method,
    required String receptionistName,
    required String receiptCode,
    DateTime? createdAt,
  }) = _DepositImpl;

  factory Deposit.fromJson(Map<String, dynamic> jsonSerialization) {
    return Deposit(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      roomId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['roomId']),
      guestName: jsonSerialization['guestName'] as String,
      guestPhone: jsonSerialization['guestPhone'] as String,
      nights: jsonSerialization['nights'] as int,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      currency: _i3o61vxh.CurrencyCode.fromJson(
        (jsonSerialization['currency'] as String),
      ),
      method: _ie3b7ann.PaymentMethod.fromJson(
        (jsonSerialization['method'] as String),
      ),
      receptionistName: jsonSerialization['receptionistName'] as String,
      receiptCode: jsonSerialization['receiptCode'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = DepositTable();

  static const db = DepositRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue organizationId;

  _is.UuidValue roomId;

  String guestName;

  String guestPhone;

  int nights;

  double amount;

  _i3o61vxh.CurrencyCode currency;

  _ie3b7ann.PaymentMethod method;

  String receptionistName;

  String receiptCode;

  DateTime createdAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Deposit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Deposit copyWith({
    _is.UuidValue? id,
    _is.UuidValue? organizationId,
    _is.UuidValue? roomId,
    String? guestName,
    String? guestPhone,
    int? nights,
    double? amount,
    _i3o61vxh.CurrencyCode? currency,
    _ie3b7ann.PaymentMethod? method,
    String? receptionistName,
    String? receiptCode,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Deposit',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'roomId': roomId.toJson(),
      'guestName': guestName,
      'guestPhone': guestPhone,
      'nights': nights,
      'amount': amount,
      'currency': currency.toJson(),
      'method': method.toJson(),
      'receptionistName': receptionistName,
      'receiptCode': receiptCode,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Deposit',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'roomId': roomId.toJson(),
      'guestName': guestName,
      'guestPhone': guestPhone,
      'nights': nights,
      'amount': amount,
      'currency': currency.toJson(),
      'method': method.toJson(),
      'receptionistName': receptionistName,
      'receiptCode': receiptCode,
      'createdAt': createdAt.toJson(),
    };
  }

  static DepositInclude include() {
    return DepositInclude._();
  }

  static DepositIncludeList includeList({
    _is.WhereExpressionBuilder<DepositTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DepositTable>? orderBy,
    _is.OrderByListBuilder<DepositTable>? orderByList,
    DepositInclude? include,
  }) {
    return DepositIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Deposit.t),
      orderByList: orderByList?.call(Deposit.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DepositImpl extends Deposit {
  _DepositImpl({
    _is.UuidValue? id,
    required _is.UuidValue organizationId,
    required _is.UuidValue roomId,
    required String guestName,
    required String guestPhone,
    required int nights,
    required double amount,
    required _i3o61vxh.CurrencyCode currency,
    required _ie3b7ann.PaymentMethod method,
    required String receptionistName,
    required String receiptCode,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         roomId: roomId,
         guestName: guestName,
         guestPhone: guestPhone,
         nights: nights,
         amount: amount,
         currency: currency,
         method: method,
         receptionistName: receptionistName,
         receiptCode: receiptCode,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Deposit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Deposit copyWith({
    Object? id = _Undefined,
    _is.UuidValue? organizationId,
    _is.UuidValue? roomId,
    String? guestName,
    String? guestPhone,
    int? nights,
    double? amount,
    _i3o61vxh.CurrencyCode? currency,
    _ie3b7ann.PaymentMethod? method,
    String? receptionistName,
    String? receiptCode,
    DateTime? createdAt,
  }) {
    return Deposit(
      id: id is _is.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      roomId: roomId ?? this.roomId,
      guestName: guestName ?? this.guestName,
      guestPhone: guestPhone ?? this.guestPhone,
      nights: nights ?? this.nights,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      method: method ?? this.method,
      receptionistName: receptionistName ?? this.receptionistName,
      receiptCode: receiptCode ?? this.receiptCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class DepositUpdateTable extends _is.UpdateTable<DepositTable> {
  DepositUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> organizationId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.organizationId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> roomId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.roomId,
        value,
      );

  _is.ColumnValue<String, String> guestName(String value) => _is.ColumnValue(
    table.guestName,
    value,
  );

  _is.ColumnValue<String, String> guestPhone(String value) => _is.ColumnValue(
    table.guestPhone,
    value,
  );

  _is.ColumnValue<int, int> nights(int value) => _is.ColumnValue(
    table.nights,
    value,
  );

  _is.ColumnValue<double, double> amount(double value) => _is.ColumnValue(
    table.amount,
    value,
  );

  _is.ColumnValue<_i3o61vxh.CurrencyCode, _i3o61vxh.CurrencyCode> currency(
    _i3o61vxh.CurrencyCode value,
  ) => _is.ColumnValue(
    table.currency,
    value,
  );

  _is.ColumnValue<_ie3b7ann.PaymentMethod, _ie3b7ann.PaymentMethod> method(
    _ie3b7ann.PaymentMethod value,
  ) => _is.ColumnValue(
    table.method,
    value,
  );

  _is.ColumnValue<String, String> receptionistName(String value) =>
      _is.ColumnValue(
        table.receptionistName,
        value,
      );

  _is.ColumnValue<String, String> receiptCode(String value) => _is.ColumnValue(
    table.receiptCode,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class DepositTable extends _is.Table<_is.UuidValue?> {
  DepositTable({super.tableRelation}) : super(tableName: 'deposit') {
    updateTable = DepositUpdateTable(this);
    organizationId = _is.ColumnUuid(
      'organizationId',
      this,
    );
    roomId = _is.ColumnUuid(
      'roomId',
      this,
    );
    guestName = _is.ColumnString(
      'guestName',
      this,
    );
    guestPhone = _is.ColumnString(
      'guestPhone',
      this,
    );
    nights = _is.ColumnInt(
      'nights',
      this,
    );
    amount = _is.ColumnDouble(
      'amount',
      this,
    );
    currency = _is.ColumnEnum(
      'currency',
      this,
      _is.EnumSerialization.byName,
    );
    method = _is.ColumnEnum(
      'method',
      this,
      _is.EnumSerialization.byName,
    );
    receptionistName = _is.ColumnString(
      'receptionistName',
      this,
    );
    receiptCode = _is.ColumnString(
      'receiptCode',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final DepositUpdateTable updateTable;

  late final _is.ColumnUuid organizationId;

  late final _is.ColumnUuid roomId;

  late final _is.ColumnString guestName;

  late final _is.ColumnString guestPhone;

  late final _is.ColumnInt nights;

  late final _is.ColumnDouble amount;

  late final _is.ColumnEnum<_i3o61vxh.CurrencyCode> currency;

  late final _is.ColumnEnum<_ie3b7ann.PaymentMethod> method;

  late final _is.ColumnString receptionistName;

  late final _is.ColumnString receiptCode;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    organizationId,
    roomId,
    guestName,
    guestPhone,
    nights,
    amount,
    currency,
    method,
    receptionistName,
    receiptCode,
    createdAt,
  ];
}

class DepositInclude extends _is.IncludeObject {
  DepositInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => Deposit.t;
}

class DepositIncludeList extends _is.IncludeList {
  DepositIncludeList._({
    _is.WhereExpressionBuilder<DepositTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Deposit.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => Deposit.t;
}

class DepositRepository {
  const DepositRepository._();

  /// Returns a list of [Deposit]s matching the given query parameters.
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
  Future<List<Deposit>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DepositTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DepositTable>? orderBy,
    _is.OrderByListBuilder<DepositTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Deposit>(
      where: where?.call(Deposit.t),
      orderBy: orderBy?.call(Deposit.t),
      orderByList: orderByList?.call(Deposit.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Deposit] matching the given query parameters.
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
  Future<Deposit?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DepositTable>? where,
    int? offset,
    _is.OrderByBuilder<DepositTable>? orderBy,
    _is.OrderByListBuilder<DepositTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Deposit>(
      where: where?.call(Deposit.t),
      orderBy: orderBy?.call(Deposit.t),
      orderByList: orderByList?.call(Deposit.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Deposit] by its [id] or null if no such row exists.
  Future<Deposit?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Deposit>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Deposit]s in the list and returns the inserted rows.
  ///
  /// The returned [Deposit]s will have their `id` fields set.
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
  Future<List<Deposit>> insert(
    _is.DatabaseSession session,
    List<Deposit> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Deposit>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Deposit] and returns the inserted row.
  ///
  /// The returned [Deposit] will have its `id` field set.
  Future<Deposit> insertRow(
    _is.DatabaseSession session,
    Deposit row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Deposit>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Deposit]s in the list and returns the resulting rows.
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
  /// The returned [Deposit]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Deposit>> upsert(
    _is.DatabaseSession session,
    List<Deposit> rows, {
    required _is.ColumnSelections<DepositTable> conflictColumns,
    _is.ColumnSelections<DepositTable>? updateColumns,
    _is.WhereExpressionBuilder<DepositTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Deposit>(
      rows,
      conflictColumns: conflictColumns(Deposit.t),
      updateColumns: updateColumns?.call(Deposit.t),
      updateWhere: updateWhere?.call(Deposit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Deposit] and returns the resulting row.
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
  /// The returned [Deposit] will have its `id` field set.
  Future<Deposit?> upsertRow(
    _is.DatabaseSession session,
    Deposit row, {
    required _is.ColumnSelections<DepositTable> conflictColumns,
    _is.ColumnSelections<DepositTable>? updateColumns,
    _is.WhereExpressionBuilder<DepositTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Deposit>(
      row,
      conflictColumns: conflictColumns(Deposit.t),
      updateColumns: updateColumns?.call(Deposit.t),
      updateWhere: updateWhere?.call(Deposit.t),
      transaction: transaction,
    );
  }

  /// Updates all [Deposit]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Deposit>> update(
    _is.DatabaseSession session,
    List<Deposit> rows, {
    _is.ColumnSelections<DepositTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Deposit>(
      rows,
      columns: columns?.call(Deposit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Deposit]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Deposit> updateRow(
    _is.DatabaseSession session,
    Deposit row, {
    _is.ColumnSelections<DepositTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Deposit>(
      row,
      columns: columns?.call(Deposit.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Deposit] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Deposit?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<DepositUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Deposit>(
      id,
      columnValues: columnValues(Deposit.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Deposit]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Deposit>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DepositUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DepositTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DepositTable>? orderBy,
    _is.OrderByListBuilder<DepositTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Deposit>(
      columnValues: columnValues(Deposit.t.updateTable),
      where: where(Deposit.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Deposit.t),
      orderByList: orderByList?.call(Deposit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Deposit]s in the list and returns the deleted rows.
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
  Future<List<Deposit>> delete(
    _is.DatabaseSession session,
    List<Deposit> rows, {
    _is.OrderByBuilder<DepositTable>? orderBy,
    _is.OrderByListBuilder<DepositTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Deposit>(
      rows,
      orderBy: orderBy?.call(Deposit.t),
      orderByList: orderByList?.call(Deposit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Deposit].
  Future<Deposit> deleteRow(
    _is.DatabaseSession session,
    Deposit row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Deposit>(
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
  Future<List<Deposit>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DepositTable> where,
    _is.OrderByBuilder<DepositTable>? orderBy,
    _is.OrderByListBuilder<DepositTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Deposit>(
      where: where(Deposit.t),
      orderBy: orderBy?.call(Deposit.t),
      orderByList: orderByList?.call(Deposit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DepositTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Deposit>(
      where: where?.call(Deposit.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Deposit] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DepositTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Deposit>(
      where: where(Deposit.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
