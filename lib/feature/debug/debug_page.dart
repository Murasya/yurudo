import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/core/design/app_color.dart';
import 'package:routine_app/core/services/notification_service.dart';
import 'package:routine_app/core/utils/contextEx.dart';

import '../../repository/todo/todo_provider.dart';

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
              ref.watch(notificationServiceProvider).testNotification();
              context.showSnackBar(
                const SnackBar(
                  content: Text('通知をセットしました'),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('実施が遅れているゆるDOを作る'),
            onTap: () {
              ref.read(todoProvider.notifier).create(
                    name: '実施が遅れているゆるDO',
                    span: 1,
                    firstDay: DateTime.now().add(const Duration(days: -1)),
                    remind: true,
                    categoryId: 0,
                    time: 5,
                  );
              context.showSnackBar(
                const SnackBar(
                  content: Text('実施が遅れているゆるDOを作りました'),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('前日に実施されたタスク(2日に1回)を作る'),
            onTap: () {
              ref.read(todoProvider.notifier).create(
                    name: '前日に実施済みのタスク(2日に1回)',
                    span: 2,
                    firstDay: DateTime.now().add(const Duration(days: 1)),
                    remind: true,
                    categoryId: 0,
                    completeDate: [
                      DateTime.now().add(const Duration(days: -1))
                    ],
                    time: 5,
                  );
              context.showSnackBar(
                const SnackBar(
                  content: Text('前日に実施済みのタスク(2日に1回)を作りました'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
