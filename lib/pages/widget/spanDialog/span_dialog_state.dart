import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'span_dialog_state.freezed.dart';

enum SpanType {
  day("日", 1),
  week("週", 7),
  month("か月", 30);

  final String label;
  final int term;

  const SpanType(this.label, this.term);
}

final spanDialogStateProvider =
    StateNotifierProvider.autoDispose<SpanDialogStateNotifier, SpanDialogState>(
        (ref) => SpanDialogStateNotifier());

class SpanDialogStateNotifier extends StateNotifier<SpanDialogState> {
  SpanDialogStateNotifier() : super(const SpanDialogState());

  void onChangeSpan(int span) {
    state = state.copyWith(span: span);
  }

  void onChangeSpanType(SpanType spanType) {
    state = state.copyWith(spanType: spanType);
  }
}

@freezed
class SpanDialogState with _$SpanDialogState {
  const factory SpanDialogState({
    /// 選んでいる日にち
    @Default(1) int span,

    /// 選んでいるスパンの種類
    @Default(SpanType.day) SpanType spanType,
  }) = _SpanDialogState;
}
