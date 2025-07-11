import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String description;
  final String createdAt;
  final TaskMarker? marker;
  final bool isCompleted;
  final ValueChanged<bool?> onCheckboxChanged;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.createdAt,
    this.marker,
    this.isCompleted = false,
    required this.onCheckboxChanged,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.noirVioletBack,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                CustomCheckbox(
                  value: widget.isCompleted,
                  onChanged: widget.onCheckboxChanged,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 1,
                    children: [
                      Text(
                        widget.createdAt,
                        style: context.theme.textTheme.titleMedium!.copyWith(
                          color: context.colors.gray,
                        ),
                      ),
                      Text(
                        widget.title,
                        style: context.theme.textTheme.headlineMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.description,
                        style: context.theme.textTheme.titleMedium!.copyWith(
                          color: context.colors.gray,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Center(
                  child: Icon(
                    Icons.person,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      if (widget.marker != null)
        Positioned(
          top: 0,
          right: 20,
          child: widget.marker!,
        ),
    ]);
  }
}
