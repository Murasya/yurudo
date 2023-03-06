import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/databases/todo_database.dart';
import 'package:routine_app/model/todo.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier(TodoDatabase());
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  final TodoDatabase _database;

  TodoNotifier(this._database) : super([]) {
    getAll();
  }

  Future<void> complete({
    required Todo todo,
    required DateTime completeDay,
    DateTime? nextDay,
  }) async {
    final now = DateTime.now();
    final completeIndex = todo.date.indexOf(completeDay);
    // 完了フラグを変更
    var updateTodo = todo.copyWith(
      isCompleted: todo.isCompleted.map((e) {
        if (todo.isCompleted.indexOf(e) == completeIndex) {
          return true;
        } else {
          return e;
        }
      }).toList(),
    );
    // 次回実施日がある場合はさらに追加
    if (nextDay != null) {
      updateTodo = updateTodo.copyWith(
        date: [...updateTodo.date, nextDay],
        isCompleted: [...updateTodo.isCompleted, false],
        updatedAt: now,
      );
    }
    _database.update(updateTodo);
    state = [
      for (var s in state)
        if (s.id == updateTodo.id) updateTodo else s
    ];
  }

  Future<void> update(Todo todo) async {
    final newTodo = todo.copyWith(
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
    int time = 0,
  }) async {
    final now = DateTime.now();
    // 次回実施日、作成日、更新日を追加
    final Todo todo = Todo(
      name: name,
      span: span,
      remind: remind,
      time: time,
      isCompleted: [false, false],
      categoryId: categoryId,
      date: [firstDay, firstDay.add(Duration(days: span))],
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
}
