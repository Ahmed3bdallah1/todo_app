import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:todo/utilties/task_model.dart';

class DbHelper {

  static Future<void> tables(sql.Database database) async {
    await database.execute(
        "CREATE TABLE todos("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "title STRING, description TEXT,date STRING, "
        "startTime STRING,endTime STRING, "
        "reminder INTEGER, repeat STRING, "
        "isCompleted INTEGER"
            ")",
    );

    await database.execute("CREATE TABLE user("
        "id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0, "
        "isVerified INTEGER)");
  }

  static Future<sql.Database> Db() {
    return sql.openDatabase("Todo App", version: 1,
        onCreate: (sql.Database database, int version) async {
      await tables(database);
    });
  }

  static Future<int> createItem(TaskModel taskModel) async {
    final db = await DbHelper.Db();

    final id = await db.insert("todos", taskModel.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<int> createUser(int isVerified) async {
    final db = await DbHelper.Db();

    final data = {
      'id': 1,
      'isVerified': isVerified,
    };

    final id = await db.insert("user", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await DbHelper.Db();
    return db.query("user", orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getTodos() async {
    final db = await DbHelper.Db();
    return db.query("todos", orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getTodo(int id) async {
    final db = await DbHelper.Db();
    return db.query("todos", where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> update(int id, String title, String description,
      String date, String start, String end, int isCompleted) async {
    final db = await DbHelper.Db();

    final data={
      "title":title,
      "description":description,
      "date":date,
      "startTime":start,
      "endTime":end,
      "isCompleted":isCompleted
    };

    final result= await db.update("todos", data,where: "id = ?",whereArgs: [id]);

    return result;
  }
  
  static Future<void> delete(int id) async{
    final db = await DbHelper.Db();
    
    try{
      db.delete("todos",where: "id = ?",whereArgs: [id]);
    }catch(e){
      debugPrint("Unable to delete this todo $e ");
    }
  }
}
