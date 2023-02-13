import 'package:routine_app/design/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/category.dart';

class CategoryDatabase {
  final tableName = 'categoryNames';
  final defaultCategoryNames = [
    '規定の色',
    '',
    '',
    '',
    '',
  ];

  static const defaultCategory = [
    Category(
      categoryId: AppColor.categoryDefault,
      name: '規定の色',
    ),
    Category(
      categoryId: AppColor.category1,
      name: '',
    ),
    Category(
      categoryId: AppColor.category2,
      name: '',
    ),
    Category(
      categoryId: AppColor.category3,
      name: '',
    ),
    Category(
      categoryId: AppColor.category4,
      name: '',
    ),
  ];

  Future<void> setCategoryName(int index, String name) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? names = prefs.getStringList(tableName);
    if (names != null) {
      names[index] = name;
      prefs.setStringList(tableName, names);
    }
  }

  Future<void> setCategoryNames(List<String> names) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(tableName, names);
  }

  Future<List<String>> getCategoryNames() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? categoryNames =
        prefs.getStringList(tableName) ?? defaultCategoryNames;
    return categoryNames;
  }
}
