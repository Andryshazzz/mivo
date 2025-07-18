import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  Priority _selectedPriority = Priority.high;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  const InputFormField(
                    hintText: 'Enter title here',
                    maxLength: 30,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AppPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  const InputFormField(
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: PrioritySelector(
                selected: _selectedPriority,
                onChanged: (value) {
                  setState(() => _selectedPriority = value);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(10),
        child: CustomButton(text: 'Continue', onPressed: () {}),
      ),
    );
  }
}
