import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'span_dialog_state.freezed.dart';

enum SpanType {
  day("日", 1, 6),
  week("週", 7, 5),
  month("か月", 30, 12);

  final String label;
  final int term;
  final int limit;

  const SpanType(this.label, this.term, this.limit);
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
    if (state.span > spanType.limit) {
      state = state.copyWith(span: spanType.limit);
    }
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
