import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme.dart';

enum MarkerColor {
  red,
  green,
  orange,
}

class TaskMarker extends StatelessWidget {
  final String text;
  final MarkerColor color;

  const TaskMarker({
    super.key,
    required this.text,
    required this.color,
  });

  Color _getBackgroundColor(BuildContext context) {
    switch (color) {
      case MarkerColor.red:
        return context.colors.red;
      case MarkerColor.green:
        return context.colors.green;
      case MarkerColor.orange:
        return context.colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          text,
          style: context.theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
