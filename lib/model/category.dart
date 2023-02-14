import 'dart:ui';

class Category {
  /// カテゴリID（カラーコード）
  final Color categoryId;
  /// カテゴリ名
  final String name;

  const Category({
    required this.categoryId,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId.value,
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryId: Color(map['categoryId'] as int),
      name: map['name'] as String,
    );
  }

  Category copyWith({
    Color? categoryId,
    String? name,
  }) {
    return Category(
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
    );
  }
}
