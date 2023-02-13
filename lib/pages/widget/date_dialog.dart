import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

class DateDialog {
  final void Function(Picker, List<int>)? onConfirm;

  DateDialog({
    required this.onConfirm,
  });

  void showDialog(BuildContext context) {
    Picker(
      title: const Text('開催日'),
      hideHeader: true,
      adapter: DateTimePickerAdapter(
        customColumnType: [0, 1, 2],
        isNumberMonth: true,
      ),
      cancelText: 'キャンセル',
      confirmText: 'OK',
      onConfirm: onConfirm,
    ).showDialog(context);
  }
}
