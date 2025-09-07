import 'package:db/db/db.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../app/utils/dismiss_tap.dart';
import '../../app/utils/validators.dart';
import '../task/controller/task_bloc.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  final GlobalKey<FormState> _createKey = GlobalKey<FormState>();

  Priority? _priorityValue = Priority.low;
  List<String?> _selectedCategories = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _dateController = TextEditingController(
      text: DateFormat('dd.MM.yyyy').format(DateTime.now()),
    );
  }

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
          body: Form(
            key: _createKey,
            child: KeyboardDismissOnTap(
              child: CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: context.colors.background,
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
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
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
                            validator: AppValidators.validateTitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AppPadding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          Text(
                            'Date',
                            style: context.theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InputFormField.date(
                            controller: _dateController,
                            hintText: DateFormat(
                              'dd.MM.yy',
                            ).format(DateTime.now()),
                            validator: AppValidators.validateDate,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AppPadding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
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
                            counterText: '',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AppPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
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
                          CategorySelector(
                            onCategoriesSelected: (value) {
                              setState(() {
                                _selectedCategories = value;
                              });
                            },
                          ),
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
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  if (!_createKey.currentState!.validate()) return;

                  final title = _titleController.text.trim();
                  final description = _descriptionController.text.trim();
                  final todo = TodoCardCompanion(
                    name: Value(title),
                    description: Value(description),
                    category: Value(_selectedCategories.join('|')),
                    priority: Value(_priorityValue?.toInt),
                    createdAt: Value(
                      DateFormat('dd.MM.yy').parse(_dateController.text),
                    ),
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
