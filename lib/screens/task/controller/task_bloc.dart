import 'dart:async';

import 'package:db/db/db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../repos/task_repo.dart';

part 'task_event.dart';

part 'task_state.dart';

@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TodoRepository repo;
  StreamSubscription<List<TodoCardData>>? _subscription;

  TaskBloc({required this.repo}) : super(TaskState()) {
    on<LoadTodos>(_onLoad);
    on<AddTodo>(_onAdd);
    on<ToggleTodoComplete>(_onToggle);
    on<_TodosUpdated>(_onUpdated);
  }

  Future<void> _onLoad(LoadTodos event, Emitter<TaskState> emit) async {
    await _subscription?.cancel();
    _subscription = repo.getTasks().listen((todos) {
      add(_TodosUpdated(todos));
    });
  }

  Future<void> _onAdd(AddTodo event, Emitter<TaskState> emit) async {
    await repo.addTodo(event.todo);
  }

  Future<void> _onToggle(
    ToggleTodoComplete event,
    Emitter<TaskState> emit,
  ) async {
    await repo.toggleComplete(event.id, event.isCompleted);
  }

  Future<void> _onUpdated(_TodosUpdated event, Emitter<TaskState> emit) async {
    emit(state.copyWith(todos: event.todos));
  }
}
