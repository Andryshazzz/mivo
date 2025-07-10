import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime createdAt;
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

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.noirViolet,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colors.lavenderEcho.withOpacity(0.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomCheckbox(
                    value: isCompleted,
                    onChanged: onCheckboxChanged,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: context.theme.textTheme.bodyLarge?.copyWith(
                        color: context.colors.gray,
                        fontWeight: FontWeight.w600,
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ],
              ),
              if (description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  description,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: context.colors.gray.withOpacity(0.7),
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                _formatDate(createdAt),
                style: context.theme.textTheme.bodySmall?.copyWith(
                  color: context.colors.gray.withOpacity(0.5),
                ),
              ),
            ],
          ),
          if (marker != null)
            Positioned(
              top: 0,
              right: 0,
              child: marker!,
            ),
        ],
      ),
    );
  }
}
