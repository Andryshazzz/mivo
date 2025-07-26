import 'package:db/db.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@singleton
class Database {
  final db = AppDatabase();

  Stream<List<TodoCardData>> getTasks() {
    return db.select(db.todoCard).watch();
  }

  Future<void> addTask(TodoCardCompanion entry) async {
    await db.into(db.todoCard).insert(entry);
  }

  Future<void> toggleComplete(int id, bool isCompleted) async {
    await (db.update(db.todoCard)..where(
      (tbl) => tbl.id.equals(id),
    )).write(TodoCardCompanion(isCompleted: Value(isCompleted)));
  }

  Future<void> deleteTask(int id) async {
    await (db.delete(db.todoCard)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> saveUserName(String name) async {
    await db.into(db.userName).insert(UserNameCompanion(name: Value(name)));
  }

  Future<String?> getUserName() async {
    final user = await (db.select(db.userName)..limit(1)).getSingleOrNull();
    return user?.name;
  }

  Future<bool> hasUser() async {
    return await getUserName() != null;
  }
}
