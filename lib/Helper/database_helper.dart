import 'package:api_internet_without_internet/Model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{

  static Database? _database;
  static final DatabaseHelper db = DatabaseHelper._();
  DatabaseHelper._();

  static final _databaseName = "posts.db";
  static final table = 'posts';
  static final columnId = 'id';
  static final columnUserId = 'userId';
  static final columnTitle = 'title';
  static final columnBody = 'body';

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, '$_databaseName');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE $table($columnUserId TEXT,$columnId TEXT, $columnTitle TEXT , $columnBody TEXT)');
        });
  }

  insert(Model newposts) async {
    final db = await database;
    await db!.rawDelete('DELETE FROM $table');
    final res = await db.insert('$table', newposts.toJson());
    return res;
  }

  fetchPostsData() async {
    final db = await database;
    return await db!.rawQuery("SELECT * FROM $table");
  }

  Future<int?> deleteData(int id) async {
    var db = await this.database;
    return await db?.rawDelete('DELETE FROM $table WHERE $columnId = $id');
  }

  Future<dynamic?> update(Map<String, dynamic> row) async {
    Database? db = await database;
    int id = row[columnId];
    return await db?.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

}
