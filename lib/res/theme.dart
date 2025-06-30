import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ProjectColors.light2,
    //inputDecorationTheme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ProjectColors.light1,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ProjectColors.red1),
      ),
      hintStyle: ProjectTextStyles.outfitRegular.copyWith(
        color: ProjectColors.dark1,
      ),
      contentPadding: EdgeInsets.all(12),
    ),
  );
}

class ProjectColors {
  static const light1 = Color(0xFFFFFFFF);
  static const light2 = Color(0xFFF6F6F6);
  static const red1 = Color(0xFFF62525);
  static const red2 = Color(0xFFF2796B);
  static const dark1 = Color(0xFF545151);
  static const dark2 = Color(0xFF5B5B5B);
  static const dark3 = Color(0xFF757171);
}

class ProjectTextStyles {
  static var poppinsLight = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
    fontSize: 12,
  );

  static var poppinsLight2 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );

  static TextStyle poppinsRegular = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 13,
  );

  static TextStyle poppinsBold = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    fontSize: 17,
  );

  static TextStyle outfitRegular = TextStyle(
    fontFamily: 'Outfit',
    fontWeight: FontWeight.w400,
    fontSize: 13,
  );

  static TextStyle outfitBold = TextStyle(
    fontFamily: 'Outfit',
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );

  static TextStyle heading1 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    fontSize: 28,
  );

  static TextStyle subtitle = TextStyle(
    fontFamily: 'Outfit',
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
}

class ProjectIcons {
  static const String google = 'assets/icons/google.svg';
  static const String user = 'assets/icons/user.svg';
  static const String mainImage = 'assets/images/main_image.png';
}
