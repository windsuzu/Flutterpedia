import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

final String tableName = 'user';
final String columnId = '_id';
final String columnEmail = 'email';
final String columnName = 'name';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  static Database _db;
  final _lock = new Lock();

  DatabaseProvider._internal();

  factory DatabaseProvider() {
    return _instance;
  }

  Future<Database> get db async {
    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          _db = await initDb();
        }
      });
    }
    return _db;
  }

  Future initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'local_storage.db');
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}
    return _db = await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName (
    $columnId integer primary key autoincrement,
    $columnEmail text not null,
    $columnName text not null)
    ''');
  }

  Future close() async => _db.close();
}
