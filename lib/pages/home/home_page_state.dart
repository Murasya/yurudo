import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_state.freezed.dart';

enum TermType {
  day('日', 1),
  week('週', 7);
  //month('月', 30);

  const TermType(this.displayName, this.term);

  final String displayName;
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
            pageDate: DateTime.now(),
            today: DateTime.now(),
          ),
        );

  void changeDay(int index) {
    state = state.copyWith(
      pageDate: state.today.add(Duration(days: index * state.displayTerm.term)),
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void updateToday() {
    if (!isSameDay(state.today, DateTime.now())) {
      state = state.copyWith(today: DateTime.now());
    }
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
    /// 表示期間
    @Default(TermType.day) TermType displayTerm,

    /// 今日
    required DateTime today,

    /// 表示している日付
    required DateTime pageDate,
  }) = _HomePageState;
}
