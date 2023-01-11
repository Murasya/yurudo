import 'package:routine_app/design/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/category.dart';

class CategoryDatabase {
  final tableName = 'categoryNames';
  final defaultCategoryNames = [
    '規定の色',
    '1',
    '2',
    '3',
    '4',
  ];

  static const defaultCategory = [
    Category(categoryId: AppColor.categoryDefault, name: '規定の色',),
    Category(categoryId: AppColor.category1, name: '1',),
    Category(categoryId: AppColor.category2, name: '2',),
    Category(categoryId: AppColor.category3, name: '3',),
    Category(categoryId: AppColor.category4, name: '4',),
  ];

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
