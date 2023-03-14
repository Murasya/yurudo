import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/todo.dart';
import '../../viewModel/todo_provider.dart';

part 'home_page_state.freezed.dart';

enum FilterType {
  all,
}

enum TermType {
  day('日', 1),
  week('週', 7),
  month('月', 30);

  const TermType(this.displayName, this.term);

  final String displayName;
  final int term;
}

final homePageStateProvider =
    StateNotifierProvider.autoDispose<HomePageStateNotifier, HomePageState>(
        (ref) {
  return HomePageStateNotifier(
    ref.watch(todoProvider),
  );
});

class HomePageStateNotifier extends StateNotifier<HomePageState> {
  HomePageStateNotifier(
    List<Todo> todo,
  ) : super(
          HomePageState(
            todoList: todo,
            pageDate: DateTime.now(),
            today: DateTime.now(),
          ),
        );

  void changeDay(int index) {
    state = state.copyWith(
      pageDate: state.today.add(Duration(days: index * state.displayTerm.term)),
    );
  }

  void changeTerm(TermType type) {
    state = state.copyWith(
      displayTerm: type,
    );
  }
}

@freezed
class HomePageState with _$HomePageState {
  factory HomePageState({
    /// タスクリスト
    @Default([]) List<Todo> todoList,

    /// 絞り込み
    @Default(FilterType.all) FilterType filter,

    /// 表示期間
    @Default(TermType.day) TermType displayTerm,

    /// 今日
    required DateTime today,

    /// 表示している日付
    required DateTime pageDate,
  }) = _HomePageState;
}
