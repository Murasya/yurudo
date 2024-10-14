import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../repository/todo/todo.dart';

part 'next_schedule_state.freezed.dart';

final nextScheduleStateProvider = StateNotifierProvider.autoDispose
    .family<NextScheduleStateNotifier, NextScheduleState, NextScheduleArgs>(
        (ref, args) {
  return NextScheduleStateNotifier(args);
});

class NextScheduleStateNotifier extends StateNotifier<NextScheduleState> {
  NextScheduleStateNotifier(NextScheduleArgs args)
      : super(
          NextScheduleState(
            displayMonth: args.completeDay,
            selectDay: args.completeDay.add(
              Duration(days: args.todo.span),
            ),
            completeDay: DateTime.now(),
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

  void setCompleteDay(DateTime date, int span) {
    state = state.copyWith(
      completeDay: date,
      selectDay: date.add(Duration(days: span))
    );
  }

  void setError(bool error, {String msg = ''}) {
    state = state.copyWith(
      hasError: error,
      errorMessage: msg,
    );
  }
}

@freezed
class NextScheduleArgs with _$NextScheduleArgs {
  const factory NextScheduleArgs({
    required Todo todo,
    required DateTime completeDay,
  }) = _NextScheduleArgs;
}

@freezed
class NextScheduleState with _$NextScheduleState {
  const factory NextScheduleState({
    required DateTime displayMonth,
    required DateTime selectDay,
    required DateTime completeDay,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _NextScheduleState;
}
