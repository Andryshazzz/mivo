import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme.dart';

enum ButtonType { primary, auth }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Widget? icon;
  final ButtonType type;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.borderRadius,
    this.padding,
    this.icon,
    this.type = ButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = context.colors;
    final defaultStyles = _getDefaultStyle(type, theme, colors);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? defaultStyles.backgroundColor,
          foregroundColor: foregroundColor ?? defaultStyles.foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? defaultStyles.borderRadius,
          ),
          padding: padding ?? defaultStyles.padding,
          textStyle: textStyle ?? defaultStyles.textStyle,
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  const SizedBox(width: 8),
                  Text(text),
                ],
              )
            : Text(text),
      ),
    );
  }
}

class ButtonStyleDefaults {
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final TextStyle textStyle;

  ButtonStyleDefaults({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderRadius,
    required this.padding,
    required this.textStyle,
  });
}

ButtonStyleDefaults _getDefaultStyle(
    ButtonType type, ThemeData theme, ProjectColorsExtension colors) {
  switch (type) {
    case ButtonType.primary:
      return ButtonStyleDefaults(
        backgroundColor: colors.lavenderEcho,
        foregroundColor: colors.white,
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.symmetric(vertical: 18),
        textStyle: theme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      );
    case ButtonType.auth:
      return ButtonStyleDefaults(
        backgroundColor: colors.noirVioletLight,
        foregroundColor: colors.white,
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.symmetric(vertical: 18),
        textStyle: theme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      );
  }
}
