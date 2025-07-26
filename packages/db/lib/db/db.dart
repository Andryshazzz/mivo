import 'dart:io';

import 'package:db/tables/todocard_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:l/l.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../tables/user_table.dart';

part 'db.g.dart';

@DriftDatabase(tables: [TodoCard, UserData])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          LazyDatabase(
            () async {
              final dbFolder = await getApplicationDocumentsDirectory();
              final file = File(p.join(dbFolder.path, 'mivo_db_v1.sqlite'));
              return NativeDatabase(file, logStatements: true);
            },
          ),
        );

  AppDatabase.forTesting(DatabaseConnection super.connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from == 1) {
            // await migration
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<void> resetDatabase() async {
    await close();

    final file = File(
      p.join(
        (await getApplicationDocumentsDirectory()).path,
        'mivo_db_v1.sqlite',
      ),
    );
    if (file.existsSync()) {
      await file.delete();
      l.i('Database deleted: $file');
    } else {
      l.w('Database not found at: $file');
    }
  }
}
