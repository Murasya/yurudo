import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:routine_app/model/todo.dart';

part 'new_task_page_state.freezed.dart';

final newTaskPageStateProvider = StateNotifierProvider.autoDispose<
    NewTaskPageStateNotifier, NewTaskPageState>((ref) {
  return NewTaskPageStateNotifier();
});

class NewTaskPageStateNotifier extends StateNotifier<NewTaskPageState> {
  NewTaskPageStateNotifier() : super(const NewTaskPageState(todo: Todo()));

  void updateTodo(todo) {
    state = state.copyWith(
      todo: todo,
    );
  }
}

@freezed
class NewTaskPageState with _$NewTaskPageState {
  const factory NewTaskPageState({
    required Todo todo,
  }) = _NewTaskPageState;
}
