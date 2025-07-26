import 'dart:async';

import 'package:db/db/db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../repos/task_repo.dart';

part 'task_event.dart';

part 'task_state.dart';

@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TodoRepository todoRepository;

  TaskBloc({required this.todoRepository}) : super(TaskState()) {
    on<TaskEvent>(
      (event, emit) => switch (event) {
        LoadTasksEvent() => _onLoad(event, emit),
        AddTaskEvent() => _onAdd(event, emit),
        DeleteTaskEvent() => _onDelete(event, emit),
        ToggleCompleteTaskEvent() => _onToggle(event, emit),
        _TaskUpdated() => _onUpdated(event, emit),
      },
    );
  }

  Future<void> _onLoad(LoadTasksEvent event, Emitter<TaskState> emit) async {
    await emit.forEach<List<TodoCardData>>(
      todoRepository.getTasks(),
      onData: (todos) => state.copyWith(tasks: todos),
    );
  }

  Future<void> _onDelete(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    await todoRepository.deleteTask(event.id);
  }

  Future<void> _onAdd(AddTaskEvent event, Emitter<TaskState> emit) async {
    await todoRepository.addTodo(event.task);
  }

  Future<void> _onToggle(
    ToggleCompleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    await todoRepository.toggleComplete(event.id, event.isCompleted);
  }

  Future<void> _onUpdated(_TaskUpdated event, Emitter<TaskState> emit) async {
    emit(state.copyWith(tasks: event.tasks));
  }
}
