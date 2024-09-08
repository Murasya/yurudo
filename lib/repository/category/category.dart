import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

@freezed
class Category with _$Category {
  const factory Category({
    /// カテゴリNo.
    required int id,

    /// カラー
    required Color color,

    /// カテゴリ名
    @Default('') String name,
  }) = _Category;
}
