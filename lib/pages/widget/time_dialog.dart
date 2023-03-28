import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:routine_app/utils/contextEx.dart';

class TimeDialog {
  final void Function(Picker, List<int>)? onConfirm;

  TimeDialog({
    required this.onConfirm,
  });

  void showDialog(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter(
        pickerData: [
          List.generate(60, (index) => (index + 1) * 5),
        ],
        isArray: true,
      ),
      delimiter: [
        PickerDelimiter(
          child: Container(
            alignment: Alignment.center,
            child: const Text('分'),
          ),
        ),
      ],
      hideHeader: true,
      title: Text(
        '必要時間を設定してください',
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium!.copyWith(fontSize: 16),
      ),
      cancelText: 'キャンセル',
      confirmText: 'OK',
      onConfirm: onConfirm,
    ).showDialog(context);
  }
}
