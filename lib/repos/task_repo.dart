import 'package:db/db/db.dart';
import 'package:drift/drift.dart' show Value;

class TodoRepository {
  final AppDatabase db;

  TodoRepository(this.db);

  Stream<List<TodoCardData>> watchAll() {
    return db.select(db.todoCard).watch();
  }

  Future<void> addTodo(TodoCardCompanion entry) async {
    await db.into(db.todoCard).insert(entry);
  }

  Future<void> toggleComplete(int id, bool isCompleted) async {
    await (db.update(db.todoCard)..where(
      (tbl) => tbl.id.equals(id),
    )).write(TodoCardCompanion(isCompleted: Value(isCompleted)));
  }
}
