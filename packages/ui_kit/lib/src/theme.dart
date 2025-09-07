import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme_style/icons.dart';
import 'package:ui_kit/src/theme_style/text_style.dart';

import 'theme_style/colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(primary: ProjectColors.lavenderEcho),
    scaffoldBackgroundColor: ProjectColors.noirViolet,
    textTheme: _buildTextTheme(),
    bottomNavigationBarTheme: _buildNavTheme(),
    popupMenuTheme: _buildPopupMenuTheme(),
  );

  static ThemeData themeOf(BuildContext context) => Theme.of(context);

  static PopupMenuThemeData _buildPopupMenuTheme() {
    return PopupMenuThemeData(
      menuPadding: EdgeInsets.zero,
      color: ProjectColors.noirViolet.withValues(alpha: 0.1),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
    );
  }

  static TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: ProjectTextStyles.workSansBold,
      headlineMedium: ProjectTextStyles.workSansSemiBold,
      titleLarge: ProjectTextStyles.workSansRegular,
      titleMedium: ProjectTextStyles.workSansMedium,
    );
  }

  static BottomNavigationBarThemeData _buildNavTheme() {
    return BottomNavigationBarThemeData(
      backgroundColor: ProjectColors.noirViolet,
      selectedItemColor: ProjectColors.lavenderEcho,
      unselectedItemColor: ProjectColors.gray.withValues(alpha: 0.6),
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: const IconThemeData(size: 28),
      unselectedIconTheme: const IconThemeData(size: 24),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    );
  }
}

class ProjectColorsExtension {
  const ProjectColorsExtension();

  Color get white => ProjectColors.white;

  Color get gray => ProjectColors.gray;

  Color get grayDark => ProjectColors.grayDark;

  Color get noirVioletLight => ProjectColors.noirVioletLight;

  Color get noirVioletBack => ProjectColors.noirVioletBack;

  Color get noirVioletBackGradient => ProjectColors.noirVioletBackGradient;

  Color get noirViolet => ProjectColors.noirViolet;

  Color get lavenderEcho => ProjectColors.lavenderEcho;

  Color get red => ProjectColors.red;

  Color get orange => ProjectColors.orange;

  Color get green => ProjectColors.green;
}

class ProjectIconsExtension {
  const ProjectIconsExtension();

  String get tasks => ProjectIcons.tasks;

  String get plan => ProjectIcons.plan;

  String get user => ProjectIcons.user;

  String get setting => ProjectIcons.setting;

  String get trash => ProjectIcons.trash;

  String get more => ProjectIcons.more;

  String get chevron_right => ProjectIcons.chevron_right;

  String get chevron_left => ProjectIcons.chevron_left;

  String get plus => ProjectIcons.plus;

  String get pencil => ProjectIcons.pencil;

  String get info => ProjectIcons.info;

  String get error => ProjectIcons.error;

  String get close => ProjectIcons.close;
}

extension ThemeShortcuts on BuildContext {
  ProjectColorsExtension get colors => const ProjectColorsExtension();

  ProjectIconsExtension get icons => const ProjectIconsExtension();

  ThemeData get theme => AppTheme.themeOf(this);
}
