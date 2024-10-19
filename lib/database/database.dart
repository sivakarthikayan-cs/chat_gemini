import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

import 'dao/chat_response_dao.dart';

part 'database.g.dart';

// Todo Responses table
class ChatResponse extends Table {
  IntColumn get id => integer().named("_id").autoIncrement()();
  TextColumn get message => text().named("message")();
  TextColumn get response => text().named("response").nullable()();
  TextColumn get createdAt => text().named("created_at").nullable()();
  TextColumn? get updatedAt => text().named("updated_at").nullable()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, "gatt.sqlite"));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [
    ChatResponse,
  ],
  daos: [
    ChatResponseDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Database version
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {},
    );
  }
}
