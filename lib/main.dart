import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:routine_app/databases/todo_database.dart';
import 'package:routine_app/design/app_color.dart';
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
  await dotenv.load(fileName: ".env");

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
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.backgroundColor,
          centerTitle: true,
          toolbarTextStyle: TextStyle(
            color: AppColor.fontColor,
          ),
          elevation: 0,
        ),
        colorScheme: const ColorScheme.light(
          primary: AppColor.primaryColor,
          secondary: AppColor.primaryColor,
          background: AppColor.backgroundColor,
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
        fontFamily: 'NotoSansJP',
        textTheme: TextTheme(
          bodySmall: const TextStyle(
            color: AppColor.fontColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          bodyMedium: const TextStyle(
            color: AppColor.fontColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          bodyLarge: const TextStyle(
            color: AppColor.fontColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          labelMedium: GoogleFonts.harmattan(
            color: AppColor.fontColor2,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
          labelLarge: GoogleFonts.harmattan(
            color: AppColor.emphasisColor,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      initialRoute: AppRouter.home,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
      ],
    );
  }
}
