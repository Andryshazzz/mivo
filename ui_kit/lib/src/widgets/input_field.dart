import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: '+380',
      style: context.theme.textTheme.bodyLarge?.copyWith(
        color: context.colors.gray,
        fontWeight: FontWeight.w600,
      ),
      cursorColor: context.colors.lavenderEcho,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.colors.noirViolet,
        // фон
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: context.colors.lavenderEcho.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colors.lavenderEcho),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      keyboardType: TextInputType.phone,
    );
  }
}
