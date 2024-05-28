import 'package:flutter/material.dart';

import 'app_color.dart';

class AppStyle {
  static final primaryButton = ElevatedButton.styleFrom(
    minimumSize: const Size(0, 40),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    foregroundColor: AppColor.onPrimary,
    backgroundColor: AppColor.primary,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );
}

extension TextStyleEx on TextStyle? {
  TextStyle? get primary => this?.copyWith(color: AppColor.primary);

  TextStyle? get emphasis => this?.copyWith(color: AppColor.emphasis);
}
