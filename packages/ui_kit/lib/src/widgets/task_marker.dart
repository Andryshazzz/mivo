import 'package:flutter/material.dart';

import '../../ui_kit.dart';

class TaskMarker extends StatelessWidget {
  final int priority;

  const TaskMarker({
    super.key,
    required this.priority,
  });

  Color _getBackgroundColor(BuildContext context) {
    switch (priority) {
      case 1:
        return context.colors.green;
      case 2:
        return context.colors.orange;
      case 3:
        return context.colors.red;
      default:
        return context.colors.green;
    }
  }

  String _getPriority() {
    switch (priority) {
      case 1:
        return 'L';
      case 2:
        return 'M';
      case 3:
        return 'H';
      default:
        return "L";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MarkerPainter(color: _getBackgroundColor(context)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
            .copyWith(bottom: 10),
        child: Text(
          _getPriority(),
          style: context.theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colors.white,
          ),
        ),
      ),
    );
  }
}

class _MarkerPainter extends CustomPainter {
  final Color color;

  _MarkerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - 8)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height - 8)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MarkerPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
