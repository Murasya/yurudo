import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_dialog_state.freezed.dart';

final timeDialogStateProvider =
    StateNotifierProvider.autoDispose<TimeDialogStateNotifier, TimeDialogState>(
        (ref) => TimeDialogStateNotifier());

class TimeDialogStateNotifier extends StateNotifier<TimeDialogState> {
  TimeDialogStateNotifier() : super(const TimeDialogState());

  void onChangeTime(int time) {
    state = state.copyWith(time: time);
  }
}

@freezed
class TimeDialogState with _$TimeDialogState {
  const factory TimeDialogState({
    /// 選んでいる時間
    @Default(5) int time,
  }) = _TimeDialogState;
}
