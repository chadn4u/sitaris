import 'package:sitaris/core/sqlite/config/config.dart';
import 'package:sqflite/sqflite.dart';

import '../dbconfig.dart';

class ConfigDAO {
  Database? _db;

  ConfigDAO() {}

  Future<void> getDbInstance() async {
    _db = await DbConfig().getInstance(query: ConfigTable().getInstance());
    return;
  }

  Future<int> insert(ConfigTable todo) async {
    int id = await _db!.insert(ConfigTable.tableName, todo.toJson());
    return id;
  }

  Future<List<ConfigTable>> getAllConfig() async {
    List<ConfigTable> list = [];

    List<Map> maps = await _db!.query(ConfigTable.tableName, columns: [
      ConfigTable.columnCode,
      ConfigTable.columnVersion,
      ConfigTable.columnBool,
      ConfigTable.columnDouble,
      ConfigTable.columnInt,
      ConfigTable.columnString
    ]);

    if (maps.length > 0) list = ConfigTable.fromJsonList(maps);

    return list;
  }

  Future<ConfigTable?> getConfigById(String? id) async {
    List<Map<String, dynamic>> maps = await _db!.query(ConfigTable.tableName,
        columns: [
          ConfigTable.columnCode,
          ConfigTable.columnVersion,
          ConfigTable.columnBool,
          ConfigTable.columnDouble,
          ConfigTable.columnInt,
          ConfigTable.columnString
        ],
        where: '${ConfigTable.columnCode} = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return ConfigTable.fromJson(maps.first);
    }

    return null;
  }

  Future<int> delete(String id) async =>
      await _db!.delete(ConfigTable.tableName,
          where: '${ConfigTable.columnCode} = ?', whereArgs: [id]);

  Future<void> deleteAllData() async {
    _db!.rawQuery("DELETE FROM ${ConfigTable.tableName}");
  }

  Future<int> update(ConfigTable todo) async =>
      await _db!.update(ConfigTable.tableName, todo.toJson(),
          where: '${ConfigTable.columnCode} = ?',
          whereArgs: [todo.labelConfig]);

  Future close() async => _db!.close();
}
