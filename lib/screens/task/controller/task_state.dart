part of 'task_bloc.dart';

class TaskState {
  final List<TodoCardData> tasks;

  TaskState({this.tasks = const []});

  TaskState copyWith({List<TodoCardData>? tasks}) {
    return TaskState(tasks: tasks ?? this.tasks);
  }
}
