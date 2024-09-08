import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/core/utils/contextEx.dart';

import 'calendar.dart';
import 'date_dialog_state.dart';

class DateDialog extends ConsumerWidget {
  final void Function(DateTime) onConfirm;
  final void Function() onCancel;
  final DateTime? initialDate;

  const DateDialog({
    super.key,
    this.initialDate,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = dateDialogStateProvider(initialDate);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    return SimpleDialog(
      title: Text(
        '実施予定日を設定してください',
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium!.copyWith(fontSize: 16),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: calendar(
            selectedDate: state.selectDate,
            onNextMonth: notifier.onNextMonth,
            onPreviousMonth: notifier.onPreviousMonth,
            onChangeDate: notifier.onChangeDate,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: onCancel,
              child: const Text(
                'キャンセル',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () => onConfirm(state.selectDate),
              child: const Text(
                '決定',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}
