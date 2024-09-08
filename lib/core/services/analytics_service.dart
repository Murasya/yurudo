import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static Future<void> logPage(String screenName) async {
    await FirebaseAnalytics.instance.logScreenView(
      screenName: screenName,
    );
  }

  static Future<void> logAppOpen() async {
    await FirebaseAnalytics.instance.logAppOpen();
  }
}
