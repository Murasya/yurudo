import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repository/category/category.dart';

part 'new_task_page_state.freezed.dart';

final newTaskPageStateProvider = StateNotifierProvider.autoDispose<
    NewTaskPageStateNotifier, NewTaskPageState>((ref) {
  return NewTaskPageStateNotifier();
});

class NewTaskPageStateNotifier extends StateNotifier<NewTaskPageState> {
  NewTaskPageStateNotifier()
      : super(const NewTaskPageState(
          name: '',
          span: null,
          remind: true,
          firstDay: null,
        ));

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setSpan(int span) {
    state = state.copyWith(span: span);
  }

  void setCategory(Category? category) {
    state = state.copyWith(category: category);
  }

  void setTime(int? time) {
    state = state.copyWith(time: time);
  }

  void setDate(DateTime firstDay) {
    state = state.copyWith(firstDay: firstDay);
  }

  void setRemind(bool remind) {
    state = state.copyWith(remind: remind);
  }

  void setHasError(bool error, String message) {
    state = state.copyWith(hasError: error, errorMessage: message);
  }
}

@freezed
class NewTaskPageState with _$NewTaskPageState {
  const factory NewTaskPageState({
    required String name,
    required int? span,
    required bool remind,
    @Default(null) Category? category,
    @Default(null) int? time,
    required DateTime? firstDay,
    @Default(false) hasError,
    @Default('') errorMessage,
  }) = _NewTaskPageState;
}
