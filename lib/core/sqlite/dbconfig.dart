import 'package:flutter/material.dart';
import 'package:sitaris/core/sqlite/province/province.dart';
import 'package:sqflite/sqflite.dart';

class DbConfig {
  Database? _db;

  Future<Database> getInstance({dynamic tableName}) async {
    if (_db == null) {
      _db = await openDatabase('sitaris.db', version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(ProvinceTable.create());
      });
    }
    debugPrint("db nya ");

    return _db!;
  }

  close() async {
    await _db!.close();
  }
}
