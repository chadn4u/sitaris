import 'package:sitaris/base/baseSqliteDB.dart';

class KecamatanTable with BaseSqliteDB {
  static final String tableName = 'mst_kecamatan';
  static final String columnCode = 'kecamatan_code';
  static final String columnCodeCity = 'city_code';
  static final String columnName = 'kecamatan';

  late String? kecamatanCode;
  late String? kecamatanName;
  late String? cityCode;

  KecamatanTable({String? codeKecamatan, String? name, String? cityCodes}) {
    kecamatanCode = codeKecamatan;
    kecamatanName = name;
    cityCode = cityCodes;
  }

  Map<String, dynamic> toJson() => {
        columnCode: kecamatanCode,
        columnName: kecamatanName,
        columnCodeCity: cityCode
      };

  static List<KecamatanTable> fromJsonList(List<dynamic> json) =>
      json.map((i) => KecamatanTable.fromJson(i)).toList();

  KecamatanTable.fromJson(Map<String, dynamic> json) {
    kecamatanCode = json[columnCode];
    kecamatanName = json[columnName];
    cityCode = json[columnCodeCity];
  }

  BaseSqliteDB getInstance() {
    return this;
  }

  @override
  String create() {
    return "CREATE TABLE $tableName (" +
        "$columnCode TEXT PRIMARY KEY ," +
        "$columnName TEXT," +
        "$columnCodeCity TEXT" +
        ")";
  }

  @override
  String tableNames() {
    return tableName;
  }
}
