import 'package:db/db/db.dart';
import 'package:injectable/injectable.dart';
import 'package:l/l.dart';

import '../data/source/local/db.dart';

@singleton
class TodoRepository {
  final Database db;

  TodoRepository({required this.db});

  Stream<List<TodoCardData>> getTasks() {
    try {
      return db.getTasks();
    } catch (e, st) {
      l.e('$e, $st');
      rethrow;
    }
  }

  Future<void> addTodo(TodoCardCompanion entry) async {
    try {
      await db.addTask(entry);
    } catch (e, st) {
      l.e('$e, $st');
      rethrow;
    }
  }

  Future<void> toggleComplete(int id, bool isCompleted) async {
    try {
      await db.toggleComplete(id, isCompleted);
    } catch (e, st) {
      l.e('$e, $st');
      rethrow;
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await db.deleteTask(id);
    } catch (e, st) {
      l.e('$e, $st');
      rethrow;
    }
  }
}
