import 'package:sitaris/base/baseSqliteDB.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbConfig {
  Database? _db;

  Future<Database> getInstance({BaseSqliteDB? query}) async {
    if (_db == null) {
      _db = await openDatabase(join(await getDatabasesPath(), "sitaris.db"),
          version: 2, onCreate: (Database db, int version) async {
        await db.execute(query!.create());
      }, singleInstance: false);
    }
    var result = await _db!.query('sqlite_master',
        where: 'name = ?', whereArgs: [query!.tableNames()]);
    if (result.isEmpty) {
      _db!.execute(query.create());
    }

    return _db!;
  }

  close() async {
    await _db!.close();
  }
}
