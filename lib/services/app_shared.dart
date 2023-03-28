import 'package:shared_preferences/shared_preferences.dart';

class AppShared {
  late final SharedPreferences _prefs;
  static final AppShared _instance = AppShared._internal();

  factory AppShared() {
    return _instance;
  }

  AppShared._internal() {
    init();
  }

  void init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
