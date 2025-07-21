part of 'task_bloc.dart';

class TaskState {
  final List<TodoCardData> todos;

  TaskState({this.todos = const []});

  TaskState copyWith({List<TodoCardData>? todos}) {
    return TaskState(todos: todos ?? this.todos);
  }
}
