import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../next_schedule/next_schedule_state.dart';

final nextScheduleNextStateProvider = StateNotifierProvider.autoDispose
    .family<NextScheduleNextStateNotifier, NextScheduleState, NextScheduleArgs>(
        (ref, args) {
  return NextScheduleNextStateNotifier(args);
});

class NextScheduleNextStateNotifier extends StateNotifier<NextScheduleState> {
  NextScheduleNextStateNotifier(NextScheduleArgs args)
      : super(
          NextScheduleState(
            displayMonth: args.completeDay,
            selectDay: args.completeDay.add(Duration(days: args.todo.span)),
          ),
        );

  void changeMonth({bool isBefore = false}) {
    int num = 1;
    if (isBefore) num *= -1;
    state = state.copyWith(
      displayMonth: DateTime(
        state.displayMonth.year,
        state.displayMonth.month + num,
      ),
    );
  }

  void changeDate(DateTime date) {
    state = state.copyWith(
      selectDay: date,
    );
  }

  void setHasError(bool error) {
    state = state.copyWith(
      hasError: error,
    );
  }
}
