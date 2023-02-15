import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:routine_app/model/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  final tableName = 'todo';

  Future<Database> get database async {
    String dbPath = await getDatabasesPath();
    //String dbPath = (await getApplicationSupportDirectory()).path;
    final Future<Database> database = openDatabase(
      join(dbPath, '${tableName}_database.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          span INTEGER,
          remind INTEGER,
          time INTEGER,
          count INTEGER,
          skipCount INTEGER,
          skipConsecutive INTEGER,
          isCompleted INTEGER,
          categoryId INTEGER,
          date TEXT,
          beginDate TEXT,
          createdAt TEXT,
          updatedAt TEXT)
        '''
        );
      },
      version: 1,
    );
    return database;
  }

  Future<Todo> update(Todo todo) async {
    final Database db = await database;
    Todo updateTodo = todo.copyWith(
      updatedAt: DateTime.now(),
    );
    db.update(
      tableName,
      updateTodo.toMap(),
      where: 'id = ?',
      whereArgs: [updateTodo.id],
    );
    return updateTodo;
  }

  Future<void> delete(int id) async {
    final Database db = await database;
    db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 完了した場合。戻り値は[updateTodo, newTodo]
  Future<List<Todo>> complete(Todo todo) async {
    final Database db = await database;
    final now = DateTime.now();
    var oldTodo = todo.copyWith(
      isCompleted: true,
      updatedAt: now,
    );
    var newTodo = todo.copyWithNoId(
      id: null,
      count: todo.count + 1,
      date: todo.date!.add(Duration(days: todo.span)),
    );
    await db.update(
      tableName,
      oldTodo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return [oldTodo, await insert(newTodo)];
  }

  Future<Todo> insert(Todo todo) async {
    final Database db = await database;
    final now = DateTime.now();
    var newTodo = todo.copyWith(createdAt: now, updatedAt: now);
    final id = await db.insert(
      tableName,
      newTodo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return newTodo.copyWith(id: id);
  }

  Future<List<Todo>> getAll() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }
}