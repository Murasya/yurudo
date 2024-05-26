import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:routine_app/databases/todo_database.dart';
import 'package:routine_app/design/app_theme.dart';
import 'package:routine_app/router.dart';
import 'package:routine_app/services/analytics_service.dart';
import 'package:routine_app/services/app_shared.dart';
import 'package:routine_app/services/notification_service.dart';
import 'package:routine_app/utils/date.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  NotificationService().requestPermissions();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  AnalyticsService.logAppOpen();

  await AppShared.init();
  // 日付が変わっていたら初期化
  if (!AppShared.shared.lastLoginDate.isSameDay(DateTime.now())) {
    await TodoDatabase().clearPreExpectedDate();
    AppShared.shared.updateLastLoginDate();
  }
  FlutterAppBadger.removeBadge();

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ゆるDO',
      theme: AppTheme.theme,
      initialRoute: AppRouter.home,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
      ],
    );
  }
}
