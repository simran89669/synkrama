import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'constant.dart';

class UserDBHelper {
  static const _databaseName = "synkrama.db";
  static const _databaseVersion = 1;
  static const _tableName = "user";
  //columns
  static const name = "name";
  static const email = "email";
  static const password = "password";
  UserDBHelper._privateConstructor();
  static final UserDBHelper instance = UserDBHelper._privateConstructor();

  //Create Database
  static Database? _database;
  Future<Database> get database async {
    return _database ?? await _initiateDatabase();
  }

  Future<Database> _initiateDatabase() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, _databaseName);
    bool exists = await databaseExists(path);
    Database db = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $_tableName($name TEXT ,'
        '$email TEXT,'
        '$password TEXT)');
  }

  Future<int> insert(Map<String, dynamic> item) async {
    Database db = await instance.database;
    int result;
    try {
      result = await db.insert(_tableName, item);
      if(result!=0){
        errorSnackbar(msg: 'User Successfully Signed Up');
      }
      return result;
    } catch (e) {
      errorSnackbar(msg: 'Something Went Wrong');
      if (e is DatabaseException && e.isUniqueConstraintError()) {

      } else {
        throw e;

      }
      return 0;
    }
  }
  Future<int> updatePassword(String email, String password) async {
    Database db = await instance.database;
    int result = 0;
    try {
      result = await db.rawUpdate(
          'UPDATE $_tableName SET $password= ?  WHERE $email = ?',
          [password, email]);
    } catch (_) {

    }
    return result;
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db.query(_tableName);
    db.close();
    return data;
  }
  Future<List<Map<String, dynamic>>> login(String email,String password) async {
    Database db = await instance.database;
    return await db.query(
      'user',
      where: 'email = ? AND password = ?',
      whereArgs: [email,password],
    );
  }

  Future<List<Map<String, dynamic>>> findUser(String email) async {
    Database db = await instance.database;
    return await db.query(
      'user',
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
