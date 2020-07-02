import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/data_models.dart';

import 'db.dart';

class SQLiteProvider implements DbInterface {
  //Singleton
  SQLiteProvider._();
  static final SQLiteProvider db = SQLiteProvider._();

  Database _database;

  final int dbVersion = 1;
  final String dbName = 'WorkersDB.db';

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazzy initialization
    _database = await initDB();
    return _database;
  }

  @override
  Future<Database> initDB() async {
    //get patch to DB
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, dbName);

    //open DB and listen onCreate
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  //Create DB tables
  Future<void> _onCreate(Database db, int version) async {
    //Create categories table
    await db.execute('CREATE TABLE Workers ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'surname TEXT NOT NULL,'
        'name TEXT NOT NULL,'
        'middleName TEXT NOT NULL,'
        'date TEXT NOT NULL,'
        'position TEXT NOT NULL'
        ')');

    //Create tasks table
    await db.execute('CREATE TABLE Childrens ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'worker INTEGER NOT NULL,'
        'surname TEXT NOT NULL,'
        'name TEXT NOT NULL,'
        'middleName TEXT NOT NULL,'
        'date TEXT NOT NULL'
        ')');
  }

  //CRUD operations
  @override
  Future<List<Map<String, dynamic>>> select(String table,
          {bool distinct,
          List<String> columns,
          String where,
          List<dynamic> whereArgs,
          String groupBy,
          String having,
          String orderBy,
          int limit,
          int offset}) async =>
      await database.then((db) => db.query(table,
          distinct: distinct,
          columns: columns,
          where: where,
          whereArgs: whereArgs,
          groupBy: groupBy,
          having: having,
          orderBy: orderBy,
          limit: limit,
          offset: offset));

  Future<List<Map<String, dynamic>>> customSelect(String query) async =>
      await database.then((db) => db.rawQuery(query));

  @override
  Future<int> insert(String table, DataModel model) async =>
      await database.then((db) => db.insert(table, model.toMap()));

  @override
  Future<int> update(String table, DataModel model,
          {String where = 'id = ?'}) async =>
      await database.then((db) => db.update(table, model.toMap(),
          where: where, whereArgs: <dynamic>[model.id]));

  @override
  Future<int> delete(String table, DataModel model,
          {String where = 'id = ?'}) async =>
      await database.then((db) =>
          db.delete(table, where: where, whereArgs: <dynamic>[model.id]));
}
