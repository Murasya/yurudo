import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_dialog_state.freezed.dart';

final categoryDialogStateProvider = StateNotifierProvider.autoDispose
    .family<CategoryDialogStateNotifier, CategoryDialogState, int?>(
        (ref, selectNum) {
  return CategoryDialogStateNotifier(selectNum);
});

class CategoryDialogStateNotifier extends StateNotifier<CategoryDialogState> {
  CategoryDialogStateNotifier(
    int? selectNum,
  ) : super(CategoryDialogState(
          selectButtonNum: selectNum,
        ));

  void setSelectButtonNum(int? num) {
    state = state.copyWith(selectButtonNum: num);
  }
}

@freezed
class CategoryDialogState with _$CategoryDialogState {
  const factory CategoryDialogState({
    /// 選んでいるボタンの数字
    @Default(null) int? selectButtonNum,
  }) = _CategoryDialogState;
}
