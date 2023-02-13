import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/todo.dart';

part 'task_detail_page_state.freezed.dart';

final taskDetailPageStateProvider = StateNotifierProvider.family
    .autoDispose<TaskDetailPageStateNotifier, TaskDetailPageState, Todo>(
        (ref, todo) {
  return TaskDetailPageStateNotifier(todo);
});

class TaskDetailPageStateNotifier extends StateNotifier<TaskDetailPageState> {
  TaskDetailPageStateNotifier(
    Todo todo,
  ) : super(TaskDetailPageState(todo: todo));

  void updateTodo(Todo todo) {
    state = state.copyWith(
      todo: todo,
    );
  }

  void updateName(String name) {
    state = state.copyWith(
        todo: state.todo.copyWith(
      name: name,
    ));
  }
}

@freezed
class TaskDetailPageState with _$TaskDetailPageState {
  const factory TaskDetailPageState({
    /// タスク
    required Todo todo,
  }) = _TaskDetailPageState;
}
