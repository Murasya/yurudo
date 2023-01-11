import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

class DateDialog {
  final void Function(Picker, List<int>)? onConfirm;

  DateDialog({
    required this.onConfirm,
  });

  void showDialog(BuildContext context) {
    Picker(
      hideHeader: true,
      adapter: DateTimePickerAdapter(),
      onConfirm: onConfirm,
    ).showDialog(context);
  }
}
