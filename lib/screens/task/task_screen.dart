import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ui_kit/ui_kit.dart';
import '../../app/router/routes.dart';
import '../auth/controller/user_bloc.dart';
import '../auth/controller/user_state.dart';
import 'controller/task_bloc.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late PageController _pageController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onDateChanged(DateTime newDate) {
    final difference = newDate.difference(_selectedDate).inDays;
    if (difference != 0) {
      _pageController.animateToPage(
        _pageController.page!.toInt() + difference,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
    setState(() {
      _selectedDate = newDate;
    });
  }

  void _onPageChanged(int index) {
    final newDate = DateTime.now().add(Duration(days: index));
    setState(() {
      _selectedDate = newDate;
    });
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
                        RoundButton(
                          onTap: () => context.push(Routes.settings.path),
                          icon: context.icons.user,
                        ),
                        DateSelector(
                          selectedDate: _selectedDate,
                          onDateChanged: _onDateChanged,
                        ),
                        RoundButton(
                          onTap: () => context.push(Routes.settings.path),
                          icon: context.icons.setting,
                        ),
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
                          BlocSelector<UserBloc, UserState, String?>(
                            selector: (state) {
                              return state.userName;
                            },
                            builder: (context, name) {
                              return Text(
                                'Hello, $name',
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
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) {
                    final date = DateTime.now().add(Duration(days: index));
                    return AppPadding(child: _TaskListForDate(date: date));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskListForDate extends StatelessWidget {
  final DateTime date;

  const _TaskListForDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final todos =
            state.tasks.where((task) {
              return task.createdAt.year == date.year &&
                  task.createdAt.month == date.month &&
                  task.createdAt.day == date.day;
            }).toList();

        if (todos.isEmpty) {
          return Center(
            child: Text(
              'Тут задач нет',
              style: context.theme.textTheme.bodyMedium,
            ),
          );
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
                        text: todos[index].category ?? '?',
                        color: todos[index].priority!,
                      )
                      : null,
              isCompleted: todos[index].isCompleted,
              onCheckboxChanged: (newValue) {
                context.read<TaskBloc>().add(
                  ToggleCompleteTaskEvent(
                    id: todos[index].id,
                    isCompleted: newValue ?? false,
                  ),
                );
              },
              onSelected: (value) {
                if (value == 'edit') {}
                if (value == 'delete') {
                  context.read<TaskBloc>().add(
                    DeleteTaskEvent(id: todos[index].id),
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
    );
  }
}
