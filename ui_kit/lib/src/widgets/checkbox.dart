import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color? activeColor;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor ?? context.colors.lavenderEcho,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      side: BorderSide(
        color: context.colors.lavenderEcho.withOpacity(0.5),
        width: 1.5,
      ),
    );
  }
}
