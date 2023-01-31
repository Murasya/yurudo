import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

class SpanDialog {
  final void Function(Picker, List<int>)? onConfirm;

  SpanDialog({
    required this.onConfirm,
  });

  void showDialog(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter(
        pickerData: [
          [1, 2, 3, 4, 5, 6, 7],
          ['日', '週'],
        ],
        isArray: true,
      ),
      hideHeader: true,
      title: const Text('スパン設定'),
      cancelText: 'キャンセル',
      confirmText: 'OK',
      onConfirm: onConfirm,
    ).showDialog(context);
  }
}
