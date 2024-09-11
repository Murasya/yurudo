import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/core/design/app_color.dart';
import 'package:routine_app/core/design/app_style.dart';
import 'package:routine_app/core/utils/contextEx.dart';

class NextScheduleClose extends ConsumerWidget {
  const NextScheduleClose({
    super.key,
  });

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
            context.l10n.closeWithoutNext,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium!.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Text(
            context.l10n.closeWithoutNextInfo,
            style: context.textTheme.bodySmall,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: AppStyle.primaryButton.copyWith(
                textStyle: WidgetStatePropertyAll(context.textTheme.bodyLarge),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(context.l10n.finish),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: AppStyle.primaryButton.copyWith(
                textStyle: WidgetStatePropertyAll(
                  context.textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                  ),
                ),
                backgroundColor:
                    const WidgetStatePropertyAll(AppColor.buttonSecondary),
                foregroundColor:
                    const WidgetStatePropertyAll(AppColor.fontColor2),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(context.l10n.back),
            ),
          ),
        ],
      ),
    );
  }
}
