import 'package:flutter/material.dart';

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
      surface: AppColor.backgroundColor,
    ),
    dialogBackgroundColor: AppColor.backgroundColor,
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
    fontFamily: 'NotoSansJP',
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        color: AppColor.fontColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      bodyMedium: TextStyle(
        color: AppColor.fontColor,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        color: AppColor.fontColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}
