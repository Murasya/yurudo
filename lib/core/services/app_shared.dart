import 'package:shared_preferences/shared_preferences.dart';

AppShared? _instance;

class AppShared {
  final SharedPreferences _prefs;

  static AppShared get shared => _instance!;
  final String lastLoginDateKey = 'lastLoginDate';
  final String pastTodoIdsKey = 'pastTodoIds';

  const AppShared._(this._prefs);

  static Future<void> init() async {
    if (_instance != null) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    _instance = AppShared._(prefs);
  }

  DateTime? get lastLoginDate {
    final lastLoginDateStr = _prefs.getString(lastLoginDateKey);
    return DateTime.tryParse(lastLoginDateStr ?? '');
  }

  void updateLastLoginDate() {
    _prefs.setString(lastLoginDateKey, DateTime.now().toIso8601String());
  }
}
