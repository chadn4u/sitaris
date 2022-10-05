import 'package:sitaris/core/sqlite/kecamatan/kecamatan.dart';
import 'package:sqflite/sqflite.dart';

import '../dbconfig.dart';

class KecamatanDAO {
  Database? _db;

  KecamatanDAO() {}

  Future<void> getDbInstance() async {
    _db = await DbConfig().getInstance(query: KecamatanTable().getInstance());
    return;
  }

  Future<void> insert(List<KecamatanTable> todo) async {
    _db!.transaction((txn) async {
      var batch = txn.batch();
      todo.forEach((element) {
        batch.insert(KecamatanTable.tableName, element.toJson());
      });
      await batch.commit(noResult: true);
    });
    return;
    // int id = await _db!.insert(KecamatanTable.tableName, todo.toJson());
    // return id;
  }

  Future<List<KecamatanTable>> getAllKecamatan() async {
    List<KecamatanTable> list = [];

    List<Map> maps = await _db!.query(KecamatanTable.tableName,
        columns: [KecamatanTable.columnCode, KecamatanTable.columnName]);

    if (maps.length > 0) list = KecamatanTable.fromJsonList(maps);

    return list;
  }

  Future<List<KecamatanTable>?> getKecamatanWithCityCode(String id) async {
    List<Map<String, dynamic>> maps = await _db!.query(KecamatanTable.tableName,
        columns: [KecamatanTable.columnCode, KecamatanTable.columnName],
        where: '${KecamatanTable.columnCodeCity} = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return KecamatanTable.fromJsonList(maps);
    }

    return null;
  }

  Future<KecamatanTable?> getKecamatanWithKecamatanCode(String id) async {
    List<Map<String, dynamic>> maps = await _db!.query(KecamatanTable.tableName,
        columns: [KecamatanTable.columnCode, KecamatanTable.columnName],
        where: '${KecamatanTable.columnCode} = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return KecamatanTable.fromJson(maps.first);
    }

    return null;
  }

  Future<int> delete(String id) async =>
      await _db!.delete(KecamatanTable.tableName,
          where: '${KecamatanTable.columnCode} = ?', whereArgs: [id]);

  Future<void> deleteAllData() async {
    _db!.rawQuery("DELETE FROM ${KecamatanTable.tableName}");
  }

  Future<int> update(KecamatanTable todo) async =>
      await _db!.update(KecamatanTable.tableName, todo.toJson(),
          where: '${KecamatanTable.columnCode} = ?',
          whereArgs: [todo.kecamatanCode]);

  Future close() async => _db!.close();
}
