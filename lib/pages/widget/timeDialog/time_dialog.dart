import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/pages/widget/timeDialog/time_dialog_state.dart';
import 'package:routine_app/utils/contextEx.dart';

class TimeDialog extends ConsumerWidget {
  final void Function(int time) onConfirm;

  const TimeDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timeDialogStateProvider);
    final notifier = ref.read(timeDialogStateProvider.notifier);
    final items = List.generate(60, (index) => (index + 1) * 5);

    return AlertDialog(
      title: Text(
        'スパンを設定してください',
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium!.copyWith(fontSize: 16),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: DropdownButton<int>(
              value: state.time,
              isExpanded: true,
              items: items
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.toString()),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  notifier.onChangeTime(value);
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          const Text("分"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'キャンセル',
          ),
        ),
        TextButton(
          onPressed: () {
            onConfirm(state.time);
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
          ),
        ),
      ],
    );
  }
}
