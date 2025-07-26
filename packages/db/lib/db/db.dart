import 'dart:io';

import 'package:db/tables/todocard_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../tables/user_table.dart';

part 'db.g.dart';

@DriftDatabase(tables: [TodoCard, UserName])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'my_database.sqlite'));
    return NativeDatabase(file);
  });
}
