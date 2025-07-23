part of 'task_bloc.dart';

sealed class TaskEvent {}

final class LoadTodos extends TaskEvent {}

final class AddTodo extends TaskEvent {
  final TodoCardCompanion todo;

  AddTodo(this.todo);
}

final class DeleteTodo extends TaskEvent {
  final int id;

  DeleteTodo(this.id);
}

final class ToggleTodoComplete extends TaskEvent {
  final int id;
  final bool isCompleted;

  ToggleTodoComplete(this.id, this.isCompleted);
}

class _TodosUpdated extends TaskEvent {
  final List<TodoCardData> todos;

  _TodosUpdated(this.todos);
}
