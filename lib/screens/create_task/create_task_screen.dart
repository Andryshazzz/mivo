import 'package:db/db/db.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

import '../task/controller/task_bloc.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Priority? _priorityValue = Priority.low;
  String? _selectedCategory = Priority.low.toCategoryString;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: context.colors.noirViolet,
                surfaceTintColor: Colors.transparent,
                leading: AppPadding(
                  child: RoundButton(
                    onTap: () => context.pop(),
                    icon: context.icons.chevron_left,
                  ),
                ),
                title: Text(
                  'Create Task',
                  style: context.theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: AppPadding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Text(
                        'Title',
                        style: context.theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InputFormField(
                        controller: _titleController,
                        hintText: 'Enter title here',
                        maxLength: 30,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AppPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Text(
                        'Description',
                        style: context.theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InputFormField(
                        controller: _descriptionController,
                        hintText: 'Enter description here',
                        maxLength: 200,
                        maxLines: 6,
                        showCounter: true,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AppPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Text(
                        'Tags',
                        style: context.theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const CategorySelector(),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AppPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: PrioritySelector(
                    selected: _priorityValue,
                    onChanged: (value) {
                      setState(() {
                        _priorityValue = value;
                        _selectedCategory = value?.toCategoryString;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: AnimatedPadding(
            padding: EdgeInsets.only(
              bottom: bottomInset > 0 ? bottomInset + 10 : 10,
              left: 10,
              right: 10,
              top: 10,
            ),
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeOut,
            child: SafeArea(
              minimum: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Continue',
                onPressed: () {
                  final title = _titleController.text.trim();
                  final description = _descriptionController.text.trim();

                  // Сделать кастомный снэкбар
                  if (title.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Title cannot be empty')),
                    );
                    return;
                  }

                  final todo = TodoCardCompanion(
                    name: Value(title),
                    description: Value(description),
                    category: Value(_selectedCategory),
                    priority: Value(_priorityValue?.toInt),
                    createdAt: Value(DateTime.now()),
                    isCompleted: const Value(false),
                  );

                  context.read<TaskBloc>().add(AddTaskEvent(task: todo));
                  context.pop();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
