import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../next_schedule/next_schedule_state.dart';

final nextScheduleCompleteStateProvider = StateNotifierProvider.autoDispose
    .family<NextScheduleCompleteStateNotifier, NextScheduleState,
        NextScheduleArgs>((ref, args) {
  return NextScheduleCompleteStateNotifier(args);
});

class NextScheduleCompleteStateNotifier
    extends StateNotifier<NextScheduleState> {
  NextScheduleCompleteStateNotifier(NextScheduleArgs args)
      : super(
          NextScheduleState(
            displayMonth: args.completeDay,
            selectDay: args.completeDay,
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
