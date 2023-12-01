import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:routine_app/model/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  static const tableName = 'yurudo';

  static Future<String> get databasePath async {
    Directory dbDir = await getApplicationSupportDirectory();
    return join(dbDir.path, '${tableName}_database.db');
  }

  static Future restoreDatabase(DownloadTask writeToFile) async {
    await deleteDatabase(await databasePath);
    await writeToFile;
    await openDatabase(await databasePath);
  }

  Future<Database> get database async {
    final Future<Database> database = openDatabase(
      await databasePath,
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
          categoryId INTEGER,
          completeDate TEXT,
          preExpectedDate TEXT,
          expectedDate TEXT,
          createdAt TEXT,
          updatedAt TEXT)
        ''');
      },
      version: 1,
    );
    return database;
  }

  Future<void> update(Todo todo) async {
    final Database db = await database;
    db.update(
      tableName,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> clearPreExpectedDate() async {
    final Database db = await database;
    db.rawUpdate("UPDATE $tableName SET preExpectedDate = NULL");
  }

  Future<void> delete(int id) async {
    final Database db = await database;
    db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Todo> insert(Todo todo) async {
    final Database db = await database;
    final id = await db.insert(
      tableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return todo.copyWith(id: id);
  }

  Future<List<Todo>> getAll() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  Future<Todo> select(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return Todo.fromMap(maps.first);
  }
}
