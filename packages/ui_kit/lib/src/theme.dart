import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme_style/icons.dart';
import 'package:ui_kit/src/theme_style/text_style.dart';

import 'theme_style/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData themeOf(BuildContext context) => Theme.of(context);

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(primary: ProjectColors.lavenderEcho),
    scaffoldBackgroundColor: ProjectColors.noirViolet,
    extensions: <ThemeExtension<dynamic>>[
      const AppThemeStyle(
        background: ProjectColors.noirViolet,
        white: ProjectColors.white,
        gray: ProjectColors.gray,
        grayDark: ProjectColors.grayDark,
        noirVioletLight: ProjectColors.noirVioletLight,
        noirVioletBack: ProjectColors.noirVioletBack,
        noirVioletBackGradient: ProjectColors.noirVioletBackGradient,
        lavenderEcho: ProjectColors.lavenderEcho,
        red: ProjectColors.red,
        orange: ProjectColors.orange,
        green: ProjectColors.green,
      ),
    ],
    textTheme: textTheme,
    bottomNavigationBarTheme: bottomNavigationBarThemeData,
    popupMenuTheme: popupMenuThemeData,
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    colorScheme: const ColorScheme.light(primary: ProjectColors.lavenderEcho),
    scaffoldBackgroundColor: ProjectColors.white,
    extensions: <ThemeExtension<dynamic>>[
      const AppThemeStyle(
        background: ProjectColors.white,
        white: ProjectColors.white,
        gray: ProjectColors.gray,
        grayDark: ProjectColors.grayDark,
        noirVioletLight: ProjectColors.noirVioletLight,
        noirVioletBack: ProjectColors.noirVioletBack,
        noirVioletBackGradient: ProjectColors.white,
        lavenderEcho: ProjectColors.lavenderEcho,
        red: ProjectColors.red,
        orange: ProjectColors.orange,
        green: ProjectColors.green,
      ),
    ],
    textTheme: textTheme,
    bottomNavigationBarTheme: bottomNavigationBarThemeData,
    popupMenuTheme: popupMenuThemeData,
  );

  static PopupMenuThemeData popupMenuThemeData = PopupMenuThemeData(
    menuPadding: EdgeInsets.zero,
    color: ProjectColors.noirViolet.withValues(alpha: 0.1),
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 3,
  );

  static BottomNavigationBarThemeData bottomNavigationBarThemeData =
      BottomNavigationBarThemeData(
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

  static const textTheme = TextTheme(
    displayLarge: ProjectTextStyles.workSansBold,
    headlineMedium: ProjectTextStyles.workSansSemiBold,
    titleLarge: ProjectTextStyles.workSansRegular,
    titleMedium: ProjectTextStyles.workSansMedium,
  );
}

class ProjectColorsExtension {
  final BuildContext context;

  const ProjectColorsExtension(this.context);

  AppThemeStyle get appTheme => Theme.of(context).extension<AppThemeStyle>()!;

  Color get background => appTheme.background;

  Color get white => appTheme.white;

  Color get gray => appTheme.gray;

  Color get grayDark => appTheme.grayDark;

  Color get noirVioletLight => appTheme.noirVioletLight;

  Color get noirVioletBack => appTheme.noirVioletBack;

  Color get noirVioletBackGradient => appTheme.noirVioletBackGradient;

  Color get lavenderEcho => appTheme.lavenderEcho;

  Color get red => appTheme.red;

  Color get orange => appTheme.orange;

  Color get green => appTheme.green;
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
  ProjectColorsExtension get colors => ProjectColorsExtension(this);

  ProjectIconsExtension get icons => const ProjectIconsExtension();

  ThemeData get theme => AppTheme.themeOf(this);
}

class AppThemeStyle extends ThemeExtension<AppThemeStyle> {
  const AppThemeStyle({
    required this.background,
    required this.white,
    required this.gray,
    required this.grayDark,
    required this.noirVioletLight,
    required this.noirVioletBack,
    required this.noirVioletBackGradient,
    required this.lavenderEcho,
    required this.red,
    required this.orange,
    required this.green,
  });

  final Color background;
  final Color white;
  final Color gray;
  final Color grayDark;
  final Color noirVioletLight;
  final Color noirVioletBack;
  final Color noirVioletBackGradient;
  final Color lavenderEcho;
  final Color red;
  final Color orange;
  final Color green;

  @override
  AppThemeStyle copyWith({
    Color? white,
    Color? gray,
    Color? grayDark,
    Color? noirVioletLight,
    Color? noirVioletBack,
    Color? noirVioletBackGradient,
    Color? background,
    Color? lavenderEcho,
    Color? red,
    Color? orange,
    Color? green,
  }) {
    return AppThemeStyle(
      white: white ?? this.white,
      gray: gray ?? this.gray,
      grayDark: grayDark ?? this.grayDark,
      noirVioletLight: noirVioletLight ?? this.noirVioletLight,
      noirVioletBack: noirVioletBack ?? this.noirVioletBack,
      noirVioletBackGradient:
          noirVioletBackGradient ?? this.noirVioletBackGradient,
      background: background ?? this.background,
      lavenderEcho: lavenderEcho ?? this.lavenderEcho,
      red: red ?? this.red,
      orange: orange ?? this.orange,
      green: green ?? this.green,
    );
  }

  @override
  AppThemeStyle lerp(ThemeExtension<AppThemeStyle>? other, double t) {
    if (other is! AppThemeStyle) return this;

    return AppThemeStyle(
      white: Color.lerp(white, other.white, t)!,
      gray: Color.lerp(gray, other.gray, t)!,
      grayDark: Color.lerp(grayDark, other.grayDark, t)!,
      noirVioletLight: Color.lerp(noirVioletLight, other.noirVioletLight, t)!,
      noirVioletBack: Color.lerp(noirVioletBack, other.noirVioletBack, t)!,
      noirVioletBackGradient:
          Color.lerp(noirVioletBackGradient, other.noirVioletBackGradient, t)!,
      background: Color.lerp(background, other.background, t)!,
      lavenderEcho: Color.lerp(lavenderEcho, other.lavenderEcho, t)!,
      red: Color.lerp(red, other.red, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      green: Color.lerp(green, other.green, t)!,
    );
  }
}
