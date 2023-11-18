import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/databases/todo_database.dart';
import 'package:routine_app/model/todo.dart';
import 'package:routine_app/pages/taskDetail/task_detail_page_state.dart';
import 'package:routine_app/utils/contextEx.dart';
import 'package:routine_app/utils/date.dart';

import '../pages/home/widget/next_schedule/next_schedule.dart';
import '../pages/home/widget/next_schedule/next_schedule_state.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier(TodoDatabase());
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  final TodoDatabase _database;
  final dateFormat = DateFormat('M/d');

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
    List<DateTime>? completeDate,
  }) async {
    final now = DateTime.now();
    // 次回実施日、作成日、更新日を追加
    final Todo todo = Todo(
      name: name,
      span: span,
      remind: remind,
      time: time,
      categoryId: categoryId,
      completeDate: completeDate ?? [],
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

  /// チェックボックスを押した時の処理
  void onTapDailyCheckBox({
    required BuildContext context,
    required DateTime today,
    required int pageIndex,
    required Todo todo,
  }) {
    if (pageIndex > 0) {
      if (todo.isBeforeDay(today)) {
        context.showSnackBar(
          const SnackBar(content: Text('実施が遅れているゆるDOからタスクを実施してください')),
        );
      } else if (todo.expectedDate.isSameDay(today)) {
        context.showSnackBar(
          const SnackBar(content: Text('本日のゆるDOからタスクを実施してください')),
        );
      } else if (todo.isContainComplete(today)) {
        context.showSnackBar(
          const SnackBar(content: Text('1日に同一タスクは2度実施できません')),
        );
      } else if (!todo.expectedDate
          .isSameDay(today.add(Duration(days: pageIndex)))) {
        context.showSnackBar(
          SnackBar(
              content: Text(
                  '直近の同一タスク(${dateFormat.format(todo.expectedDate!)})から実施してください')),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => NextSchedule(
            args: NextScheduleArgs(
              todo: todo,
              completeDay: today,
            ),
          ),
        );
      }
      return;
    } else if (pageIndex < 0) {
      context.showSnackBar(
          const SnackBar(content: Text('過去のタスクを実施しなかったことにはできません')));
      return;
    } else if (!todo.isContainComplete(today)) {
      debugPrint('complete!');
      showDialog(
        context: context,
        builder: (_) => NextSchedule(
          args: NextScheduleArgs(
            todo: todo,
            completeDay: today,
          ),
        ),
      );
    } else {
      unComplete(
        todo: todo,
        completeDay: today,
      );
    }
  }

  /// チェックボックスを押した時の処理
  void onTapWeeklyCheckBox({
    required BuildContext context,
    required DateTime today,
    required int pageIndex,
    required Todo todo,
  }) {
    if (pageIndex < 0) {
      context.showSnackBar(
          const SnackBar(content: Text('過去のタスクを実施しなかったことにはできません')));
      return;
    } else if (todo.expectedDate.isAfterDay(today)) {
      if (_getTodayTodo(today).any((t) => t.id == todo.id)) {
        context.showSnackBar(
          const SnackBar(content: Text('本日のゆるDOからタスクを実施してください')),
        );
      } else if (todo.isContainComplete(today)) {
        context.showSnackBar(
          const SnackBar(content: Text('1日に同一タスクは2度実施できません')),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => NextSchedule(
            args: NextScheduleArgs(
              todo: todo,
              completeDay: today,
            ),
          ),
        );
      }
      return;
    } else if (!todo.isContainComplete(today)) {
      debugPrint('complete!');
      showDialog(
        context: context,
        builder: (_) => NextSchedule(
          args: NextScheduleArgs(
            todo: todo,
            completeDay: today,
          ),
        ),
      );
    } else {
      unComplete(
        todo: todo,
        completeDay: today,
      );
    }
  }

  /// 今日のタスクと実施が遅れているタスク
  List<Todo> _getTodayTodo(DateTime today) {
    return state
        .where((todo) =>
            !today.isBeforeDay(todo.expectedDate!) &&
            todo.expectedDate!.dateDiff(today) % todo.span == 0)
        .toList();
  }
}
