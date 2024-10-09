import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:routine_app/core/utils/contextEx.dart';
import 'package:routine_app/core/utils/date.dart';
import 'package:routine_app/core/utils/int_ex.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../repository/todo/todo.dart';


final notificationServiceProvider = Provider((ref) => NotificationService());

class NotificationService {
  final FlutterLocalNotificationsPlugin _flnp =
      FlutterLocalNotificationsPlugin();
  static const int notificationTime = 9;

  NotificationService() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Tokyo'));

    initializeDateFormatting('ja');
  }

  Future<void> requestPermissions() async {
    _flnp.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('ic_notification'),
      iOS: DarwinInitializationSettings(),
    ));
    await _flnp
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    await _flnp
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> registerMessage({
    int id = 0,
    required DateTime day,
    required String message,
    required BuildContext context,
    DateTime? dateTime, // test用
  }) async {
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      day.year,
      day.month,
      day.day,
      notificationTime,
    );

    if (dateTime != null) {
      scheduledDate = tz.TZDateTime(
        tz.local,
        dateTime.year,
        dateTime.month,
        dateTime.day,
        dateTime.hour,
        dateTime.minute,
        dateTime.second,
      );
    }
    DateFormat dateFormat = DateFormat('M/d(E)', 'ja');

    if (scheduledDate.isBefore(DateTime.now())) {
      return;
    }

    _flnp.zonedSchedule(
      id,
      context.l10n.checkYurudo(dateFormat.format(day)),
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily notification',
          context.l10n.todayYurudoLabel,
          channelDescription: context.l10n.notifyDailyYurudo,
          icon: 'ic_notification',
        ),
        iOS: const DarwinNotificationDetails(
          badgeNumber: 1,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    Logger().i('registerMessage: $id, $message, $scheduledDate');
  }

  Future<void> _cancelNotification() async {
    await _flnp.cancelAll();
  }

  @Deprecated('test用')
  Future<void> testNotification(BuildContext context) async {
    var time = DateTime.now().add(const Duration(minutes: 1));
    registerMessage(
      id: 1000,
      day: time,
      message: 'test message',
      context: context,
      dateTime: time,
    );
    debugPrint("test notification time$time");
  }

  /// 1週間分の通知をセットする
  Future<void> setNotifications(List<Todo> todos, BuildContext context) async {
    await _cancelNotification();

    final today = DateTime.now();
    for (int i = 1; i <= 14; i++) {
      final tomorrow = today.add(Duration(days: i));
      final tomorrowTodo = todos
          .where((todo) =>
              todo.expectedDate != null &&
              todo.expectedDate!.isSameDay(tomorrow) &&
              todo.remind)
          .toList();
      String message = '';
      for (var j = 0; j < min(3, tomorrowTodo.length); j++) {
        message +=
            '${tomorrowTodo[j].name} [${tomorrowTodo[j].time.toTimeString(context)}]\n';
      }
      registerMessage(id: i, day: tomorrow, message: message, context: context);
    }
    var list = await _flnp.getActiveNotifications();
    // listを一覧表示
    for (var item in list) {
      Logger().i('id: ${item.id}');
      Logger().i('title: ${item.title}');
      Logger().i('body: ${item.body}');
      Logger().i('payload: ${item.payload}');
    }
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    Logger().i('id ----- $id');
  }
}
