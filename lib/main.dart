import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:routine_app/core/services/analytics_service.dart';
import 'package:routine_app/core/services/app_shared.dart';
import 'package:routine_app/core/services/notification_service.dart';
import 'package:routine_app/core/utils/date.dart';
import 'package:routine_app/repository/todo/todo_database.dart';

import 'core/design/app_theme.dart';
import 'core/navigation/router.dart';
import 'core/utils/contextEx.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

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

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(notificationServiceProvider).requestPermissions();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => context.l10n.title,
      theme: AppTheme.theme,
      initialRoute: AppRouter.home,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ja"),
      ],
    );
  }
}
