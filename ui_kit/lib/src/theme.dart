import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme_style/text_style.dart';

import 'theme_style/colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(primary: ProjectColors.lavenderEcho),
    scaffoldBackgroundColor: ProjectColors.noirViolet,
    textTheme: _buildTextTheme(),
  );

  static ThemeData themeOf(BuildContext context) => Theme.of(context);

  static TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: ProjectTextStyles.workSansBold,
      headlineMedium: ProjectTextStyles.workSansSemiBold,
      titleLarge: ProjectTextStyles.workSansRegular,
      titleMedium: ProjectTextStyles.workSansMedium,
    );
  }
}

class ProjectColorsExtension {
  const ProjectColorsExtension();

  Color get white => ProjectColors.white;
  Color get gray => ProjectColors.gray;
  Color get grayDark => ProjectColors.grayDark;
  Color get noirVioletLight => ProjectColors.noirVioletLight;
  Color get noirViolet => ProjectColors.noirViolet;
  Color get lavenderEcho => ProjectColors.lavenderEcho;
}

extension ThemeShortcuts on BuildContext {
  ProjectColorsExtension get colors => const ProjectColorsExtension();
  ThemeData get theme => AppTheme.themeOf(this);
}
