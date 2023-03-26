import 'package:flutter/material.dart';

import 'app_color.dart';

class AppStyle {
  static final button = ElevatedButton.styleFrom(
      minimumSize: const Size(0, 40),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: AppColor.primaryColor,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ));
}
