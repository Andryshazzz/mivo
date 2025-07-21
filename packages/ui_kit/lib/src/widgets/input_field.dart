import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme.dart';

class InputFormField extends StatelessWidget {
  final String? hintText;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final bool showCounter;

  const InputFormField(
      {super.key,
      this.validator,
      this.controller,
      this.hintText,
      this.maxLength,
      this.showCounter = false,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      style: context.theme.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      cursorColor: context.colors.lavenderEcho,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.colors.noirViolet,
        hintText: hintText,
        hintStyle: TextStyle(color: context.colors.gray),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        counterText: showCounter ? null : '',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: context.colors.lavenderEcho.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: context.colors.lavenderEcho),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      keyboardType: TextInputType.phone,
    );
  }
}
