// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ChatResponseTable extends ChatResponse
    with TableInfo<$ChatResponseTable, ChatResponseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatResponseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      '_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _responseMeta =
      const VerificationMeta('response');
  @override
  late final GeneratedColumn<String> response = GeneratedColumn<String>(
      'response', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, message, response, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_response';
  @override
  VerificationContext validateIntegrity(Insertable<ChatResponseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('_id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['_id']!, _idMeta));
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('response')) {
      context.handle(_responseMeta,
          response.isAcceptableOrUnknown(data['response']!, _responseMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatResponseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatResponseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}_id'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      response: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}response']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ChatResponseTable createAlias(String alias) {
    return $ChatResponseTable(attachedDatabase, alias);
  }
}

class ChatResponseData extends DataClass
    implements Insertable<ChatResponseData> {
  final int id;
  final String message;
  final String? response;
  final String? createdAt;
  final String? updatedAt;
  const ChatResponseData(
      {required this.id,
      required this.message,
      this.response,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['_id'] = Variable<int>(id);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || response != null) {
      map['response'] = Variable<String>(response);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  ChatResponseCompanion toCompanion(bool nullToAbsent) {
    return ChatResponseCompanion(
      id: Value(id),
      message: Value(message),
      response: response == null && nullToAbsent
          ? const Value.absent()
          : Value(response),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ChatResponseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatResponseData(
      id: serializer.fromJson<int>(json['id']),
      message: serializer.fromJson<String>(json['message']),
      response: serializer.fromJson<String?>(json['response']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'message': serializer.toJson<String>(message),
      'response': serializer.toJson<String?>(response),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  ChatResponseData copyWith(
          {int? id,
          String? message,
          Value<String?> response = const Value.absent(),
          Value<String?> createdAt = const Value.absent(),
          Value<String?> updatedAt = const Value.absent()}) =>
      ChatResponseData(
        id: id ?? this.id,
        message: message ?? this.message,
        response: response.present ? response.value : this.response,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ChatResponseData copyWithCompanion(ChatResponseCompanion data) {
    return ChatResponseData(
      id: data.id.present ? data.id.value : this.id,
      message: data.message.present ? data.message.value : this.message,
      response: data.response.present ? data.response.value : this.response,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatResponseData(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('response: $response, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, message, response, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatResponseData &&
          other.id == this.id &&
          other.message == this.message &&
          other.response == this.response &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChatResponseCompanion extends UpdateCompanion<ChatResponseData> {
  final Value<int> id;
  final Value<String> message;
  final Value<String?> response;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  const ChatResponseCompanion({
    this.id = const Value.absent(),
    this.message = const Value.absent(),
    this.response = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChatResponseCompanion.insert({
    this.id = const Value.absent(),
    required String message,
    this.response = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : message = Value(message);
  static Insertable<ChatResponseData> custom({
    Expression<int>? id,
    Expression<String>? message,
    Expression<String>? response,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) '_id': id,
      if (message != null) 'message': message,
      if (response != null) 'response': response,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChatResponseCompanion copyWith(
      {Value<int>? id,
      Value<String>? message,
      Value<String?>? response,
      Value<String?>? createdAt,
      Value<String?>? updatedAt}) {
    return ChatResponseCompanion(
      id: id ?? this.id,
      message: message ?? this.message,
      response: response ?? this.response,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['_id'] = Variable<int>(id.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatResponseCompanion(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('response: $response, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ChatResponseTable chatResponse = $ChatResponseTable(this);
  late final ChatResponseDao chatResponseDao =
      ChatResponseDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [chatResponse];
}

typedef $$ChatResponseTableCreateCompanionBuilder = ChatResponseCompanion
    Function({
  Value<int> id,
  required String message,
  Value<String?> response,
  Value<String?> createdAt,
  Value<String?> updatedAt,
});
typedef $$ChatResponseTableUpdateCompanionBuilder = ChatResponseCompanion
    Function({
  Value<int> id,
  Value<String> message,
  Value<String?> response,
  Value<String?> createdAt,
  Value<String?> updatedAt,
});

class $$ChatResponseTableFilterComposer
    extends Composer<_$AppDatabase, $ChatResponseTable> {
  $$ChatResponseTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get response => $composableBuilder(
      column: $table.response, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ChatResponseTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatResponseTable> {
  $$ChatResponseTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get response => $composableBuilder(
      column: $table.response, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ChatResponseTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatResponseTable> {
  $$ChatResponseTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get response =>
      $composableBuilder(column: $table.response, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ChatResponseTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatResponseTable,
    ChatResponseData,
    $$ChatResponseTableFilterComposer,
    $$ChatResponseTableOrderingComposer,
    $$ChatResponseTableAnnotationComposer,
    $$ChatResponseTableCreateCompanionBuilder,
    $$ChatResponseTableUpdateCompanionBuilder,
    (
      ChatResponseData,
      BaseReferences<_$AppDatabase, $ChatResponseTable, ChatResponseData>
    ),
    ChatResponseData,
    PrefetchHooks Function()> {
  $$ChatResponseTableTableManager(_$AppDatabase db, $ChatResponseTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatResponseTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatResponseTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatResponseTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<String?> response = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
          }) =>
              ChatResponseCompanion(
            id: id,
            message: message,
            response: response,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String message,
            Value<String?> response = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
          }) =>
              ChatResponseCompanion.insert(
            id: id,
            message: message,
            response: response,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChatResponseTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatResponseTable,
    ChatResponseData,
    $$ChatResponseTableFilterComposer,
    $$ChatResponseTableOrderingComposer,
    $$ChatResponseTableAnnotationComposer,
    $$ChatResponseTableCreateCompanionBuilder,
    $$ChatResponseTableUpdateCompanionBuilder,
    (
      ChatResponseData,
      BaseReferences<_$AppDatabase, $ChatResponseTable, ChatResponseData>
    ),
    ChatResponseData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ChatResponseTableTableManager get chatResponse =>
      $$ChatResponseTableTableManager(_db, _db.chatResponse);
}
