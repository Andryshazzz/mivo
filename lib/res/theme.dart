import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(primary: ProjectColors.lavenderEcho),
    scaffoldBackgroundColor: ProjectColors.white,
    textTheme: _buildTextTheme(),
  );

  static ThemeData themeOf(BuildContext context) => Theme.of(context);

  static TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: ProjectTextStyles.workSansBold,
      displayMedium: ProjectTextStyles.workSansSemiBold,
      displaySmall: ProjectTextStyles.workSansMedium,
      headlineMedium: ProjectTextStyles.workSansRegular,
      headlineSmall: ProjectTextStyles.workSansMedium,
      titleLarge: ProjectTextStyles.workSansSemiBold,
      titleMedium: ProjectTextStyles.workSansMedium,
      titleSmall: ProjectTextStyles.workSansRegular,
      bodyLarge: ProjectTextStyles.workSansRegular,
      bodyMedium: ProjectTextStyles.workSansRegular,
      labelLarge: ProjectTextStyles.workSansMedium,
      labelSmall: ProjectTextStyles.workSansRegular,
    );
  }
}

class ProjectColors {
  static const white = Color(0xFFFFFFFF);
  static const noirViolet = Color(0xFF090813);
  static const lavenderEcho = Color(0xFF8970EC);
}

class ProjectTextStyles {
  static const workSansBold = TextStyle(
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );

  static const workSansSemiBold = TextStyle(
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );

  static const workSansRegular = TextStyle(
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static const workSansMedium = TextStyle(
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
}

class ProjectIcons {
  static const String google = 'assets/icons/google.svg';
  static const String user = 'assets/icons/user.svg';
  static const String mainImage = 'assets/images/main_image.png';
}

extension ThemeShortcuts on BuildContext {
  ThemeData get theme => AppTheme.themeOf(this);
}
