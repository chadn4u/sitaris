import 'package:sitaris/core/sqlite/city/city.dart';
import 'package:sqflite/sqflite.dart';

import '../dbconfig.dart';

class CityDao {
  Database? _db;

  CityDao() {}

  Future<void> getDbInstance() async {
    _db = await DbConfig().getInstance(query: CityTable().getInstance());
    return;
  }

  Future<void> insert(List<CityTable> todo) async {
    _db!.transaction((txn) async {
      var batch = txn.batch();
      todo.forEach((element) {
        batch.insert(CityTable.tableName, element.toJson());
      });
      await batch.commit(noResult: true);
    });
    // int id = await _db!.insert(ProvinceTable.tableName, todo.toJson());
    return;
    // int id = await _db!.insert(CityTable.tableName, todo.toJson());
    // return id;
  }

  Future<List<CityTable>> getAllCity() async {
    List<CityTable> list = [];

    List<Map> maps = await _db!.query(CityTable.tableName,
        columns: [CityTable.columnCode, CityTable.columnName]);

    if (maps.length > 0) list = CityTable.fromJsonList(maps);

    return list;
  }

  Future<List<CityTable>?> getCityWithProvinceCode(String id) async {
    List<Map<String, dynamic>> maps = await _db!.query(CityTable.tableName,
        columns: [CityTable.columnCode, CityTable.columnName],
        where: '${CityTable.columnCodeProvince} = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return CityTable.fromJsonList(maps);
    }

    return null;
  }

  Future<CityTable?> getCityWithCityCode(String id) async {
    List<Map<String, dynamic>> maps = await _db!.query(CityTable.tableName,
        columns: [CityTable.columnCode, CityTable.columnName],
        where: '${CityTable.columnCode} = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return CityTable.fromJson(maps.first);
    }

    return null;
  }

  Future<int> delete(String id) async => await _db!.delete(CityTable.tableName,
      where: '${CityTable.columnCode} = ?', whereArgs: [id]);

  Future<void> deleteAllData() async {
    _db!.rawQuery("DELETE FROM ${CityTable.tableName}");
  }

  Future<int> update(CityTable todo) async =>
      await _db!.update(CityTable.tableName, todo.toJson(),
          where: '${CityTable.columnCode} = ?', whereArgs: [todo.provinceCode]);

  Future close() async => _db!.close();
}
