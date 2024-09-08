import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'category.dart';
import 'category_database.dart';

final categoryProvider =
StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  return CategoryNotifier(CategoryDatabase());
});

class CategoryNotifier extends StateNotifier<List<Category>> {
  final CategoryDatabase _database;

  CategoryNotifier(this._database) : super(CategoryDatabase.defaultCategory) {
    _database.init().then((_) {
      getCategories();
    });
  }

  Future<void> setCategoryName(int index, String name) async {
    await _database.setCategoryName(index, name);
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) state[i].copyWith(name: name) else state[i]
    ];
  }

  Color getColor(int? id) {
    if (id == null) {
      return Colors.transparent;
    } else {
      return state.firstWhere((category) => category.id == id).color;
    }
  }

  String getName(int? id) {
    if (id == null) {
      return '';
    } else {
      return state.firstWhere((category) => category.id == id).name;
    }
  }

  void getCategories() {
    final names = _database.getCategoryNames();
    List<Category> categoryList = [];
    for (var i = 0; i < state.length; i++) {
      var s = state[i];
      categoryList.add(Category(id: i, color: s.color, name: names[i]));
    }
    state = categoryList;
  }
}
