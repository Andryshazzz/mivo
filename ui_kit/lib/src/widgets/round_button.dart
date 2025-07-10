import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback onTap;

  const RoundButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: context.colors.lavenderEcho.withOpacity(0.2),
          ),
        ),
        child: Center(
          child: Icon(
            Icons.person,
          ),
        ),
      ),
    );
  }
}
