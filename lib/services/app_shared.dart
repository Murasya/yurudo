import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/utils/date.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../viewModel/todo_provider.dart';

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

  List<int> getPastTodoIds(WidgetRef ref) {
    final now = DateTime.now();
    final lastLoginDateStr = _prefs.getString(lastLoginDateKey);
    final lastLoginDate = DateTime.tryParse(lastLoginDateStr ?? '');
    late final List<int> pastTodoIds;
    final pastTodoIdsStr = _prefs.getString(pastTodoIdsKey) ?? '';
    if (lastLoginDate.isSameDay(now) && pastTodoIdsStr.isNotEmpty) {
      pastTodoIds = pastTodoIdsStr.split(',').map((e) => int.parse(e)).toList();
    } else {
      pastTodoIds = ref
          .watch(todoProvider)
          .where((todo) =>
              todo.expectedDate != null && todo.expectedDate!.isBeforeDay(now))
          .map((e) => e.id!)
          .toList();
      _prefs.setString(pastTodoIdsKey, pastTodoIds.join(','));
    }
    _prefs.setString(lastLoginDateKey, now.toIso8601String());
    return pastTodoIds;
  }
}
