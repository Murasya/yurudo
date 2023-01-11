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

  Future<void> complete(Todo todo) async {
    final updateAndNewTodo = await _database.complete(todo);
    var updateTodo = updateAndNewTodo.first;
    var newTodo = updateAndNewTodo.last;
    final todos = [newTodo, ...state]
        .map((t) => t.id == updateTodo.id ? updateTodo : t)
        .toList();
    state = todos;
  }

  Future<void> update(Todo todo) async {
    Todo updateTodo = await _database.update(todo);
    state = [
      for (var s in state)
        if (s.id == updateTodo.id) updateTodo
        else s
    ];
  }

  Future<void> delete(int id) async {
    _database.delete(id);
    state = [
      for (var s in state)
        if (s.id != id) s
    ];
  }

  Future<void> add(Todo todo) async {
    final todoWithId = await _database.insert(todo);
    state = [todoWithId, ...state];
  }

  Future<void> getAll() async {
    state = await _database.getAll();
  }
}
