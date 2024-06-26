import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/pages/widget/spanDialog/span_dialog_state.dart';
import 'package:routine_app/utils/contextEx.dart';

class SpanDialog extends ConsumerWidget {
  final void Function(int num, SpanType type) onConfirm;

  const SpanDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(spanDialogStateProvider);
    var notifier = ref.read(spanDialogStateProvider.notifier);
    List<int> spanTime =
        List.generate(state.spanType.limit, (index) => index + 1);

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
              value: state.span,
              isExpanded: true,
              items: spanTime
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.toString()),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  notifier.onChangeSpan(value);
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButton<SpanType>(
              value: state.spanType,
              isExpanded: true,
              items: SpanType.values
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.label),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  notifier.onChangeSpanType(value);
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          const Text("に1回"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            onConfirm(state.span, state.spanType);
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
