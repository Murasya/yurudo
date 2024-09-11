import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:routine_app/core/utils/date.dart';

part 'home_page_state.freezed.dart';

const initialPage = 100;

enum TermType {
  day('day', 1),
  week('week', 7);
  //month('month', 30);

  const TermType(this.value, this.term);

  final String value;
  final int term;
}

final homePageStateProvider =
    StateNotifierProvider<HomePageStateNotifier, HomePageState>((ref) {
  return HomePageStateNotifier();
});

class HomePageStateNotifier extends StateNotifier<HomePageState> {
  HomePageStateNotifier()
      : super(
          HomePageState(
            pageIndexDay: initialPage,
            pageIndexWeek: initialPage,
            today: DateTime.now(),
          ),
        );

  void updateToday() {
    if (!state.today.isSameDay(DateTime.now())) {
      state = state.copyWith(today: DateTime.now());
    }
  }

  void changeTerm(TermType type) {
    state = state.copyWith(
      displayTerm: type,
    );
  }

  void setIndex(index) {
    switch (state.displayTerm) {
      case TermType.day:
        state = state.copyWith(pageIndexDay: index);
        break;
      case TermType.week:
        state = state.copyWith(pageIndexWeek: index);
        break;
    }
  }
}

@freezed
class HomePageState with _$HomePageState {
  const HomePageState._();

  const factory HomePageState({
    /// 表示期間
    @Default(TermType.day) TermType displayTerm,

    /// 今日
    required DateTime today,

    /// 表示しているページ番号
    required int pageIndexDay,
    required int pageIndexWeek,
  }) = _HomePageState;

  int get usingPageIndex =>
      (displayTerm == TermType.day) ? pageIndexDay : pageIndexWeek;

  DateTime get pageDate =>
      today.add(Duration(days: (usingPageIndex - 100) * displayTerm.term));
}
