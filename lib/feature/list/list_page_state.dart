import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repository/category/category.dart';

part 'list_page_state.freezed.dart';

final listPageStateProvider =
    StateNotifierProvider<ListPageStateNotifier, ListPageState>((ref) {
  return ListPageStateNotifier();
});

enum SortType {
  addDayAsc('addDayAsc', true),
  addDayDesc('addDayDesc', false),
  spanAsc('spanAsc', true),
  spanDesc('spanDesc', false),
  timeAsc('timeAsc', true),
  timeDesc('timeDesc', false);

  const SortType(this.value, this.isAsc);

  final String value;
  final bool isAsc;
}

class ListPageStateNotifier extends StateNotifier<ListPageState> {
  ListPageStateNotifier() : super(const ListPageState());

  void setSortType(SortType sortType) {
    state = state.copyWith(
      sortType: sortType,
    );
  }

  void addFilter(Category category) {
    state = state.copyWith(
      filterType: [...state.filterType, category.id],
    );
  }

  void removeFilter(Category category) {
    state = state.copyWith(
      filterType: state.filterType.where((f) => f != category.id).toList(),
    );
  }
}

@freezed
class ListPageState with _$ListPageState {
  const factory ListPageState({
    @Default(SortType.addDayAsc) SortType sortType,
    @Default([]) List<int> filterType,
  }) = _ListPageState;
}
