import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit/src/theme.dart';

class InputFormField extends StatelessWidget {
  final String? hintText;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final String? counterText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  factory InputFormField.date(
      {String? Function(String? value)? validator,
      TextEditingController? controller,
      String? hintText,
      int maxLength = 8,
      int maxLines = 1,
      String counterText = '',
      TextInputType keyboardType = TextInputType.number}) {
    return InputFormField(
      validator: validator,
      controller: controller,
      hintText: hintText,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      counterText: counterText,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        LengthLimitingTextInputFormatter(8),
        _DateInputFormatter(),
      ],
    );
  }

  const InputFormField(
      {super.key,
      this.validator,
      this.controller,
      this.hintText,
      this.maxLength,
      this.counterText,
      this.maxLines,
      this.keyboardType,
      this.inputFormatters});

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
        errorStyle: context.theme.textTheme.titleMedium!
            .copyWith(fontSize: 12, color: context.colors.red),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        counterText: counterText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: context.colors.lavenderEcho.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: context.colors.lavenderEcho),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: context.colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: context.colors.red),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    final cleanText = text.replaceAll('.', '');
    var formattedText = '';

    for (var i = 0; i < cleanText.length; i++) {
      if (i == 2 || i == 4) formattedText += '.';
      if (i < 6) formattedText += cleanText[i];
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
