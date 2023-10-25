import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/databases/todo_database.dart';
import 'package:routine_app/model/todo.dart';
import 'package:routine_app/pages/taskDetail/task_detail_page_state.dart';
import 'package:routine_app/utils/date.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier(TodoDatabase());
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  final TodoDatabase _database;

  TodoNotifier(this._database) : super([]) {
    getAll();
  }

  Future<void> clearPreExpectedDate() async {
    _database.clearPreExpectedDate();
    state = state.map((s) => s.copyWith(preExpectedDate: null)).toList();
  }

  Future<void> complete({
    required Todo todo,
    required DateTime completeDay,
    DateTime? nextDay,
  }) async {
    final now = DateTime.now();
    // 完了処理
    todo = todo.copyWith(
      completeDate: [...todo.completeDate, completeDay],
      preExpectedDate: () => todo.expectedDate,
      expectedDate: () => nextDay,
      updatedAt: now,
    );
    _database.update(todo);
    state = [
      for (var s in state)
        if (s.id == todo.id) todo else s
    ];
  }

  Future<void> unComplete({
    required Todo todo,
    required DateTime completeDay,
  }) async {
    final now = DateTime.now();
    // 完了処理
    todo = todo.copyWith(
      completeDate:
          todo.completeDate.where((d) => !d.isSameDay(completeDay)).toList(),
      preExpectedDate: null,
      expectedDate: () => todo.preExpectedDate,
      updatedAt: now,
    );
    _database.update(todo);
    state = [
      for (var s in state)
        if (s.id == todo.id) todo else s
    ];
  }

  Future<void> update(Todo todo, TaskDetailPageState data) async {
    final newTodo = todo.copyWith(
      name: data.title,
      span: data.span,
      categoryId: () => data.category?.id,
      time: data.time,
      expectedDate: () => data.nextDay,
      updatedAt: DateTime.now(),
    );
    _database.update(newTodo);
    state = [
      for (var s in state)
        if (s.id == newTodo.id) newTodo else s
    ];
  }

  Future<void> delete(int id) async {
    _database.delete(id);
    state = [
      for (var s in state)
        if (s.id != id) s
    ];
  }

  Future<void> create({
    required String name,
    required int span,
    required DateTime firstDay,
    required bool remind,
    int? categoryId,
    int? time,
  }) async {
    final now = DateTime.now();
    // 次回実施日、作成日、更新日を追加
    final Todo todo = Todo(
      name: name,
      span: span,
      remind: remind,
      time: time,
      categoryId: categoryId,
      expectedDate: firstDay,
      createdAt: now,
      updatedAt: now,
    );
    final todoWithId = await _database.insert(todo);
    state = [...state, todoWithId];
    debugPrint('added $todoWithId');
  }

  Future<void> getAll() async {
    state = await _database.getAll();
  }

  Todo getTodoFromId(int? id) {
    return state.firstWhere((todo) => todo.id == id);
  }

  /// 過去のゆるDOを取得
  List<Todo> getTodosFromDate(DateTime date) {
    List<Todo> list = state
        .where((todo) => todo.completeDate.any((d) => d.isSameDay(date)))
        .toList();
    list.sort(Todo.compareByTime);
    return list;
  }

  /// 今日のゆるDOを取得
  List<Todo> getTodayTodos(DateTime date) {
    List<Todo> list = state
        .where((todo) =>
            (todo.expectedDate.isSameDay(date) ||
                todo.completeDate.any((d) => d.isSameDay(date))) &&
            !todo.preExpectedDate.isBeforeDay(date))
        .toList();
    list.sort(Todo.compareByTime);
    return list;
  }

  /// 実施が遅れているゆるDOを取得
  List<Todo> getPastTodos(DateTime date) {
    List<Todo> list = state
        .where((todo) =>
            todo.expectedDate.isBeforeDay(date) ||
            todo.preExpectedDate.isBeforeDay(date) &&
                todo.completeDate.any((d) => d.isSameDay(date)))
        .toList();
    list.sort(Todo.compareByTime);
    return list.reversed.toList();
  }

  /// 未来のゆるDOを取得
  List<Todo> getFutureTodos(DateTime date) {
    List<Todo> list = state
        .where((todo) =>
            todo.expectedDate.isSameDay(date) ||
            todo.expectedDate!.isBeforeDay(date) &&
                todo.expectedDate!.dateDiff(date) % todo.span == 0)
        .toList();
    list.sort(Todo.compareByTime);
    return list;
  }
}
