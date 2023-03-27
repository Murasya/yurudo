import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

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
      title: const Text('要する時間'),
      cancelText: 'キャンセル',
      confirmText: 'OK',
      onConfirm: onConfirm,
    ).showDialog(context);
  }
}
