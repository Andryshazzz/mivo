import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: RoundButton(
              onTap: () => context.pop(),
              icon: context.icons.user,
            ),
            title: const Text('Create Task'),
            centerTitle: true,
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Expanded(
                    child: Center(child: Text('Экран создания тасок')),
                  ),

                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Сохранить задачу'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
