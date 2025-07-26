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
    return CustomPaint(
      painter: _MarkerPainter(color: _getBackgroundColor(context)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
            .copyWith(bottom: 16),
        child: Text(
          text,
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
