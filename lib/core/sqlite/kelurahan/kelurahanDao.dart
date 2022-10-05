import 'package:sitaris/core/sqlite/kelurahan/kelurahan.dart';
import 'package:sqflite/sqflite.dart';

import '../dbconfig.dart';

class KelurahanDAO {
  Database? _db;

  KelurahanDAO() {}

  Future<void> getDbInstance() async {
    _db = await DbConfig().getInstance(query: KelurahanTable().getInstance());
    return;
  }

  Future<void> insert(List<KelurahanTable> todo) async {
    _db!.transaction((txn) async {
      var batch = txn.batch();
      todo.forEach((element) {
        batch.insert(KelurahanTable.tableName, element.toJson());
      });
      await batch.commit(noResult: true);
    });
    return;
    // int id = await _db!.insert(KelurahanTable.tableName, todo.toJson());
    // return id;
  }

  Future<List<KelurahanTable>> getAllKelurahan() async {
    List<KelurahanTable> list = [];

    List<Map> maps = await _db!.query(KelurahanTable.tableName,
        columns: [KelurahanTable.columnCode, KelurahanTable.columnName]);

    if (maps.length > 0) list = KelurahanTable.fromJsonList(maps);

    return list;
  }

  Future<List<KelurahanTable>> getAllPostal() async {
    List<KelurahanTable> list = [];

    List<Map> maps = await _db!.query(KelurahanTable.tableName,
        columns: [KelurahanTable.columnPostal, KelurahanTable.columnCode]);

    if (maps.length > 0) list = KelurahanTable.fromJsonList(maps);

    return list;
  }

  Future<List<KelurahanTable>?> getKelurahanWithCode(String id) async {
    List<Map<String, dynamic>> maps = await _db!.query(KelurahanTable.tableName,
        columns: [KelurahanTable.columnCode, KelurahanTable.columnName],
        where: '${KelurahanTable.columnCode} = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return KelurahanTable.fromJsonList(maps);
    }

    return null;
  }

  Future<KelurahanTable?> getKelurahanWithKecamatanCode(String id) async {
    List<Map<String, dynamic>> maps = await _db!.query(KelurahanTable.tableName,
        columns: [KelurahanTable.columnCode, KelurahanTable.columnName],
        where: '${KelurahanTable.columnCodeKecamatan} = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return KelurahanTable.fromJson(maps.first);
    }

    return null;
  }

  Future<KelurahanTable?> getPostalWithKelurahanCode(String id) async {
    List<Map<String, dynamic>> maps = await _db!.query(KelurahanTable.tableName,
        columns: [KelurahanTable.columnCode, KelurahanTable.columnPostal],
        where: '${KelurahanTable.columnCode} = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return KelurahanTable.fromJson(maps.first);
    }

    return null;
  }

  Future<int> delete(String id) async =>
      await _db!.delete(KelurahanTable.tableName,
          where: '${KelurahanTable.columnCode} = ?', whereArgs: [id]);

  Future<void> deleteAllData() async {
    _db!.rawQuery("DELETE FROM ${KelurahanTable.tableName}");
  }

  Future<int> update(KelurahanTable todo) async =>
      await _db!.update(KelurahanTable.tableName, todo.toJson(),
          where: '${KelurahanTable.columnCode} = ?',
          whereArgs: [todo.kelurahanCode]);

  Future close() async => _db!.close();
}
