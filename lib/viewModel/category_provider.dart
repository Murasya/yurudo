import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/databases/category_database.dart';

import '../model/category.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  return CategoryNotifier(CategoryDatabase());
});

class CategoryNotifier extends StateNotifier<List<Category>> {
  final CategoryDatabase _database;

  CategoryNotifier(this._database) : super(CategoryDatabase.defaultCategory) {
    getCategories();
  }

  Future<void> setCategoryName(int index, String name) async {
    await _database.setCategoryName(index, name);
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) state[i].copyWith(name: name) else state[i]
    ];
  }

  Future<void> setCategoryNames(List<String> names) async {
    await _database.setCategoryNames(names);
    state = [
      for (var i = 0; i < state.length; i++) state[i].copyWith(name: names[i])
    ];
  }

  Future<void> getCategories() async {
    final names = await _database.getCategoryNames();
    List<Category> categoryList = [];
    for (var i = 0; i < state.length; i++) {
      var s = state[i];
      categoryList.add(Category(categoryId: s.categoryId, name: names[i]));
    }
    state = categoryList;
  }
}
