import 'package:flutter/material.dart';
import 'package:sitaris/core/sqlite/province/province.dart';
import 'package:sqflite/sqflite.dart';

import '../dbconfig.dart';

class ProvinceDAO {
  Database? _db;

  ProvinceDAO() {}

  Future<void> getDbInstance() async {
    _db = await DbConfig().getInstance(tableName: ProvinceTable);
    return;
  }

  Future<int> insert(ProvinceTable todo) async {
    int id = await _db!.insert(ProvinceTable.tableName, todo.toJson());
    return id;
  }

  Future<List<ProvinceTable>> getAllProvinces() async {
    List<ProvinceTable> list = [];

    List<Map> maps = await _db!.query(ProvinceTable.tableName,
        columns: [ProvinceTable.columnCode, ProvinceTable.columnName]);

    if (maps.length > 0) list = ProvinceTable.fromJsonList(maps);

    return list;
  }

  Future<ProvinceTable?> getProvince(String id) async {
    List<Map<String, dynamic>> maps = await _db!.query(ProvinceTable.tableName,
        columns: [ProvinceTable.columnCode, ProvinceTable.columnName],
        where: '${ProvinceTable.columnCode} = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return ProvinceTable.fromJson(maps.first);
    }

    return null;
  }

  Future<int> delete(String id) async =>
      await _db!.delete(ProvinceTable.tableName,
          where: '${ProvinceTable.columnCode} = ?', whereArgs: [id]);

  Future<void> deleteAllData() async {
    _db!.rawQuery("DELETE FROM ${ProvinceTable.tableName}");
  }

  Future<int> update(ProvinceTable todo) async =>
      await _db!.update(ProvinceTable.tableName, todo.toJson(),
          where: '${ProvinceTable.columnCode} = ?',
          whereArgs: [todo.provinceCode]);

  Future close() async => _db!.close();
}
