import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_kit/ui_kit.dart';

@RoutePage()
class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                AppPadding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundButton(onTap: () {}),
                      const DateSelector(),
                      RoundButton(onTap: () {}),
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
                        Text(
                          'Hello, Andrey',
                          style: context.theme.textTheme.displayLarge,
                        ),
                        Text(
                          'Have a nice day',
                          style: context.theme.textTheme.titleMedium!.copyWith(
                            color: context.colors.gray,
                          ),
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
                      RoundButton(onTap: () {}),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: AppPadding(
                child: ListView.separated(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      title: 'Task $index',
                      description: 'Task description $index',
                      createdAt: DateFormat(
                        'dd.MM.yyyy',
                      ).format(DateTime.now()),
                      marker: const TaskMarker(
                        text: 'T',
                        color: MarkerColor.green,
                      ),
                      isCompleted: _isChecked,
                      onCheckboxChanged: (newValue) {
                        setState(() {
                          _isChecked = newValue ?? false;
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
