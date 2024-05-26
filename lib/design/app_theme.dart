import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.backgroundColor,
      centerTitle: true,
      toolbarTextStyle: TextStyle(
        color: AppColor.fontColor,
      ),
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColor.primary,
      primaryContainer: AppColor.primaryContainer,
      secondary: AppColor.primary,
      background: AppColor.backgroundColor,
    ),
    dialogBackgroundColor: AppColor.backgroundColor,
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
    fontFamily: 'NotoSansJP',
    textTheme: TextTheme(
      bodySmall: const TextStyle(
        color: AppColor.fontColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      bodyMedium: const TextStyle(
        color: AppColor.fontColor,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      bodyLarge: const TextStyle(
        color: AppColor.fontColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      labelMedium: GoogleFonts.harmattan(
        color: AppColor.fontColor2,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
      labelLarge: GoogleFonts.harmattan(
        color: AppColor.emphasisColor,
        fontWeight: FontWeight.bold,
        fontSize: 28,
      ),
    ),
  );
}
