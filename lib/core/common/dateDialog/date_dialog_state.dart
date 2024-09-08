import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:routine_app/core/utils/date.dart';

part 'date_dialog_state.freezed.dart';

final dateDialogStateProvider =
    StateNotifierProvider.autoDispose<DateDialogStateNotifier, DateDialogState>(
  (ref) => DateDialogStateNotifier(),
);

class DateDialogStateNotifier extends StateNotifier<DateDialogState> {
  DateDialogStateNotifier()
      : super(DateDialogState(
          selectDate: DateTime.now(),
        ));

  void onChangeDate(DateTime date) {
    state = state.copyWith(selectDate: date);
  }

  void onNextMonth() {
    state = state.copyWith(selectDate: state.selectDate.addMonth(1));
    debugPrint(state.selectDate.toString());
  }

  void onPreviousMonth() {
    state = state.copyWith(selectDate: state.selectDate.addMonth(-1));
  }
}

@freezed
class DateDialogState with _$DateDialogState {
  const factory DateDialogState({
    /// 選んでいる日にち
    required DateTime selectDate,
  }) = _DateDialogState;
}
