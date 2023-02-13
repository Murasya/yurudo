import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/todo.dart';
import '../../viewModel/todo_provider.dart';

part 'home_page_state.freezed.dart';

enum FilterType {
  all,
}

final homePageStateProvider =
    StateNotifierProvider<HomePageStateNotifier, HomePageState>((ref) {
  return HomePageStateNotifier(
    ref.watch(todoProvider),
  );
});

class HomePageStateNotifier extends StateNotifier<HomePageState> {
  HomePageStateNotifier(
    List<Todo> todo,
  ) : super(HomePageState(
          todoList: todo,
        ));
}

@freezed
class HomePageState with _$HomePageState {
  factory HomePageState({
    /// タスクリスト
    @Default([]) List<Todo> todoList,

    /// 絞り込み
    @Default(FilterType.all) FilterType filter,

    /// 表示期間（0: 全て、1: 今日、2: 今週、3: 今月）
    @Default(0) int displayTerm,
  }) = _HomePageState;
}
