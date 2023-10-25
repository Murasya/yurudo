import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/design/app_color.dart';
import 'package:routine_app/services/notification_service.dart';
import 'package:routine_app/utils/contextEx.dart';
import 'package:routine_app/viewModel/todo_provider.dart';

class DebugPage extends ConsumerWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('デバッグメニュー'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        foregroundColor: AppColor.fontColor,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('1分後に通知を送る'),
            onTap: () {
              NotificationService().testNotification();
              context.showSnackBar(
                const SnackBar(
                  content: Text('通知をセットしました'),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('前日のタスクを作る'),
            onTap: () {
              ref.read(todoProvider.notifier).create(
                    name: '前日のタスク',
                    span: 1,
                    firstDay: DateTime.now().add(const Duration(days: -1)),
                    remind: true,
                    categoryId: 0,
                    time: 5,
                  );
              context.showSnackBar(
                const SnackBar(
                  content: Text('前日のタスクを作りました'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
