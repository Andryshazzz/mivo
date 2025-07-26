part of 'task_bloc.dart';

sealed class TaskEvent {}

final class LoadTasksEvent extends TaskEvent {}

final class AddTaskEvent extends TaskEvent {
  final TodoCardCompanion task;

  AddTaskEvent({required this.task});
}

final class DeleteTaskEvent extends TaskEvent {
  final int id;

  DeleteTaskEvent({required this.id});
}

final class ToggleCompleteTaskEvent extends TaskEvent {
  final int id;
  final bool isCompleted;

  ToggleCompleteTaskEvent({required this.id, required this.isCompleted});
}

class _TaskUpdated extends TaskEvent {
  final List<TodoCardData> tasks;

  _TaskUpdated(this.tasks);
}
