import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/utils/date.dart';
import 'package:routine_app/utils/int_ex.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../model/todo.dart';

class NotificationService {
  late final FlutterLocalNotificationsPlugin _flnp;
  static const int notificationTime = 9;

  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal() {
    _flnp = FlutterLocalNotificationsPlugin();
    initializeNotification();
  }

  Future<void> initializeNotification() async {
    // android/app/src/main/res/drawable をフォルダーに追加する必要あり
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flnp.initialize(initializationSettings);

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Tokyo'));

    initializeDateFormatting('ja');
  }

  Future<void> requestPermissions() async {
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
    DateTime? dateTime, // test用
  }) async {
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, day.year, day.month, day.day, notificationTime);

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
      '${dateFormat.format(day)}のゆるDOを確認しましょう',
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily notification',
          '今日のゆるDO',
          ongoing: true,
          styleInformation: BigTextStyleInformation(message),
        ),
        iOS: const DarwinNotificationDetails(
          badgeNumber: 1,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> _cancelNotification() async {
    await _flnp.cancelAll();
  }

  @Deprecated('test用')
  Future<void> testNotification() async {
    var time = DateTime.now().add(const Duration(minutes: 1));
    registerMessage(
      id: 1000,
      day: time,
      message: 'test message',
      dateTime: time,
    );
    debugPrint("test notification time$time");
  }

  /// 1週間分の通知をセットする
  Future<void> setNotifications(List<Todo> todos) async {
    await _cancelNotification();

    final today = DateTime.now();
    for (int i = 1; i <= 7; i++) {
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
            '${tomorrowTodo[j].name} [${tomorrowTodo[j].time.toTimeString()}]\n';
      }
      registerMessage(id: i, day: tomorrow, message: message);
    }
    var list = await _flnp.getActiveNotifications();
    // listを一覧表示
    for (var item in list) {
      debugPrint('id: ${item.id}');
      debugPrint('title: ${item.title}');
      debugPrint('body: ${item.body}');
      debugPrint('payload: ${item.payload}');
    }
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    debugPrint('id ----- $id');
  }
}
