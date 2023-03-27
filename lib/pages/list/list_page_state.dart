import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/category.dart';

part 'list_page_state.freezed.dart';

final listPageStateProvider =
    StateNotifierProvider<ListPageStateNotifier, ListPageState>((ref) {
  return ListPageStateNotifier();
});

enum SortType {
  addDayAsc('追加日 (新→古)', true),
  addDayDesc('追加日 (古→新)', false),
  spanAsc('スパン (短→長)', true),
  spanDesc('スパン (長→短)', false),
  timeAsc('必要時間 (短→長)', true),
  timeDesc('必要時間 (長→短)', false);

  const SortType(this.title, this.isAsc);

  final String title;
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
