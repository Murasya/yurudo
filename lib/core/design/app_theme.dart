import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.secondaryColor,
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
    textTheme: const TextTheme(),
  );
}
