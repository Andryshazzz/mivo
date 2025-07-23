import 'package:db/db/db.dart';
import 'package:injectable/injectable.dart';

import '../data/source/local/db.dart';

@singleton
class TodoRepository {
  final Database db;

  TodoRepository({required this.db});

  Stream<List<TodoCardData>> getTasks() {
    return db.getTasks();
  }

  Future<void> addTodo(TodoCardCompanion entry) async {
    await db.addTask(entry);
  }

  Future<void> toggleComplete(int id, bool isCompleted) async {
    await db.toggleComplete(id, isCompleted);
  }

  Future<void> deleteTask(int id) async {
    await db.deleteTask(id);
  }
}
