import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ui_kit/ui_kit.dart';

import '../auth/controller/auth_bloc.dart';
import '../auth/controller/auth_state.dart';
import 'controller/task_bloc.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  MarkerColor? _priorityToColor(int priority) {
    switch (priority) {
      case 1:
        return MarkerColor.green;
      case 2:
        return MarkerColor.orange;
      case 3:
        return MarkerColor.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.colors.noirViolet,
            context.colors.noirVioletBackGradient,
          ],
          stops: const [0.7, 1],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  AppPadding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoundButton(onTap: () {}, icon: context.icons.user),
                        const DateSelector(),
                        RoundButton(onTap: () {}, icon: context.icons.setting),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  AppPadding(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BlocSelector<AuthBloc, AuthState, String?>(
                            selector: (state) {
                              if (state.userName != null) return state.userName;
                              return 'Вася';
                            },
                            builder: (context, state) {
                              return Text(
                                'Hello, $state',
                                style: context.theme.textTheme.displayLarge,
                              );
                            },
                          ),
                          Text(
                            'Have a nice day',
                            style: context.theme.textTheme.titleMedium!
                                .copyWith(color: context.colors.gray),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        const Expanded(child: CategoryTabBar()),
                        const SizedBox(width: 15),
                        RoundButton(onTap: () {}, icon: context.icons.trash),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: AppPadding(
                  child: BlocBuilder<TaskBloc, TaskState>(
                    builder: (context, state) {
                      final todos = state.todos;
                      if (state.todos.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.separated(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            title: todos[index].name,
                            description: todos[index].description ?? '',
                            createdAt: DateFormat(
                              'dd.MM.yyyy',
                            ).format(todos[index].createdAt),
                            marker:
                                todos[index].priority != null
                                    ? TaskMarker(
                                      text:
                                          todos[index].category
                                              ?.substring(0, 1)
                                              .toUpperCase() ??
                                          '?',
                                      color:
                                          _priorityToColor(
                                            todos[index].priority!,
                                          )!,
                                    )
                                    : null,
                            isCompleted: todos[index].isCompleted,
                            onCheckboxChanged: (newValue) {
                              context.read<TaskBloc>().add(
                                ToggleTodoComplete(
                                  todos[index].id,
                                  newValue ?? false,
                                ),
                              );
                            },
                            onSelected: (value) {
                              if (value == 'edit') {}
                              if (value == 'delete') {
                                context.read<TaskBloc>().add(
                                  DeleteTodo(todos[index].id),
                                );
                              }
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 15);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
