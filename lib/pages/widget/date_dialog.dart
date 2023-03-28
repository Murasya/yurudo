import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:routine_app/utils/contextEx.dart';

class DateDialog {
  final void Function(Picker, List<int>)? onConfirm;

  DateDialog({
    required this.onConfirm,
  });

  void showDialog(BuildContext context) {
    Picker(
      title: Text(
        '実施予定日を設定してください',
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium!.copyWith(fontSize: 16),
      ),
      hideHeader: true,
      adapter: DateTimePickerAdapter(
        customColumnType: [0, 1, 2],
        isNumberMonth: true,
        yearSuffix: '年',
        monthSuffix: '月',
        daySuffix: '日',
      ),
      cancelText: 'キャンセル',
      confirmText: 'OK',
      onConfirm: onConfirm,
    ).showDialog(context);
  }
}
