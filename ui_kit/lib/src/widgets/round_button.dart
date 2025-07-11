import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/src/theme.dart';

class RoundButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const RoundButton({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: context.colors.lavenderEcho.withOpacity(0.2),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SvgPicture.asset(
              icon,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
