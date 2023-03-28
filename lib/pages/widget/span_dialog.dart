import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:routine_app/utils/contextEx.dart';

class SpanDialog {
  final void Function(Picker, List<int>)? onConfirm;

  SpanDialog({
    required this.onConfirm,
  });

  void showDialog(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter(
        pickerData: [
          [1, 2, 3, 4, 5, 6],
          ['日', '週', '月'],
        ],
        isArray: true,
      ),
      delimiter: [
        PickerDelimiter(
          child: Container(
            alignment: Alignment.center,
            child: const Text('に1回'),
          ),
          column: 2,
        ),
      ],
      hideHeader: true,
      title: Text(
        'スパンを設定してください',
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium!.copyWith(fontSize: 16),
      ),
      cancelText: 'キャンセル',
      confirmText: 'OK',
      onConfirm: onConfirm,
    ).showDialog(context);
  }
}
