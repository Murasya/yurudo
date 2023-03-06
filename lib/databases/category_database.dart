import 'package:routine_app/design/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/category.dart';

class CategoryDatabase {
  final tableName = 'categoryNames';
  late final SharedPreferences _prefs;

  static const defaultCategory = [
    Category(
      id: 0,
      color: AppColor.category1,
      name: '',
    ),
    Category(
      id: 1,
      color: AppColor.category2,
      name: '',
    ),
    Category(
      id: 2,
      color: AppColor.category3,
      name: '',
    ),
    Category(
      id: 3,
      color: AppColor.category4,
      name: '',
    ),
    Category(
      id: 4,
      color: AppColor.category5,
      name: '',
    ),
  ];

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getStringList(tableName) == null) {
      await _prefs.setStringList(
        tableName,
        defaultCategory.map((e) => e.name).toList(),
      );
    }
  }

  Future<void> setCategoryName(int index, String name) async {
    List<String>? names = _prefs.getStringList(tableName);
    if (names != null) {
      names[index] = name;
      await _prefs.setStringList(tableName, names);
    } else {
      throw Exception('init()を先に呼び出してください');
    }
  }

  List<String> getCategoryNames() {
    List<String>? names = _prefs.getStringList(tableName);
    if (names == null) {
      throw Exception('init()を先に呼び出してください');
    }
    return names;
  }
}
