import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../model/todo.dart';

class NotificationService {
  late final FlutterLocalNotificationsPlugin _flnp;
  final int notificationTime = 9;

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
  }

  Future<void> registerMessage({
    required DateTime day,
    required String message,
  }) async {
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      day.year,
      day.month,
      day.day,
      notificationTime,
    );
    DateFormat dateFormat = DateFormat('M/d(E)');

    _flnp.zonedSchedule(
      0,
      '${dateFormat.format(day)}のゆるDOを確認しましょう',
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: true,
          styleInformation: BigTextStyleInformation(message),
          icon: 'ic_notification',
        ),
        iOS: const DarwinNotificationDetails(
          badgeNumber: 1,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> _cancelNotification() async {
    await _flnp.cancelAll();
  }

  Future<void> testNotification() async {
    registerMessage(
        day: DateTime.now().add(const Duration(minutes: 1)),
        message: 'test message');
  }

  /// 翌日の通知をセットする
  Future<void> setNotifications(List<Todo> todos) async {
    await _cancelNotification();

    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));
    final tomorrowTodo = todos
        .where((todo) => todo.date.any((d) =>
            isSameDay(d, tomorrow) && todo.isCompleted[todo.date.indexOf(d)]))
        .toList();
    String message = '';
    for (var i = 0; i < min(3, tomorrowTodo.length); i++) {
      message += '${tomorrowTodo[i].name} [${tomorrowTodo[i].time}\n';
    }
    registerMessage(day: tomorrow, message: message);
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    debugPrint('id ----- $id');
  }
}
