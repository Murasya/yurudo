import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:routine_app/design/app_color.dart';
import 'package:routine_app/router.dart';
import 'package:routine_app/services/notification_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  NotificationService().requestPermissions();

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        colorScheme:
            const ColorScheme.light(background: AppColor.backgroundColor),
        fontFamily: 'NotoSansJP',
        textTheme: TextTheme(
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
    );
  }
}
