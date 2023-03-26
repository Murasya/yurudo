import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/design/app_color.dart';
import 'package:routine_app/design/app_style.dart';
import 'package:routine_app/utils/contextEx.dart';

class NextScheduleClose extends ConsumerWidget {
  const NextScheduleClose({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context, false),
                child: const Icon(
                  Icons.close,
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            '次の実施予定日を設定せずに\n終わりますか？',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium!.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Text(
            '設定せずに終わると、同じゆるDOを再度実施したいとき、改めて新規で作成する必要があります。',
            style: context.textTheme.bodySmall,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: AppStyle.button.copyWith(
                textStyle:
                    MaterialStatePropertyAll(context.textTheme.bodyLarge),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('終わる'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: AppStyle.button.copyWith(
                textStyle: MaterialStatePropertyAll(
                  context.textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                  ),
                ),
                backgroundColor:
                    const MaterialStatePropertyAll(AppColor.buttonSecondary),
                foregroundColor:
                    const MaterialStatePropertyAll(AppColor.fontColor2),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('戻る'),
            ),
          ),
        ],
      ),
    );
  }
}
