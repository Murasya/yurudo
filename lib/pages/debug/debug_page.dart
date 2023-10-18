import 'package:flutter/material.dart';
import 'package:routine_app/design/app_color.dart';
import 'package:routine_app/services/notification_service.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('通知をセットしました'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
