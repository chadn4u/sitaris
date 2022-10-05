import 'package:sitaris/base/baseSqliteDB.dart';

class KelurahanTable with BaseSqliteDB {
  static final String tableName = 'mst_kelurahan';
  static final String columnCode = 'kelurahan_code';
  static final String columnCodeKecamatan = 'kecamatan_code';
  static final String columnName = 'kelurahan';
  static final String columnPostal = 'postal_code';

  late String? kelurahanCode;
  late String? kelurahanName;
  late String? kecamatanCode;
  late String? postalCode;

  KelurahanTable(
      {String? codeKecamatan,
      String? name,
      String? kelurahanCodes,
      String? zip}) {
    kecamatanCode = codeKecamatan;
    kelurahanName = name;
    kelurahanCode = kelurahanCodes;
    postalCode = zip;
  }

  Map<String, dynamic> toJson() => {
        columnCode: kelurahanCode,
        columnName: kelurahanName,
        columnCodeKecamatan: kecamatanCode,
        columnPostal: postalCode
      };

  static List<KelurahanTable> fromJsonList(List<dynamic> json) =>
      json.map((i) => KelurahanTable.fromJson(i)).toList();

  KelurahanTable.fromJson(Map<String, dynamic> json) {
    kecamatanCode = json[columnCodeKecamatan];
    kelurahanCode = json[columnCode];
    kelurahanName = json[columnName];
    postalCode = json[columnPostal];
  }

  BaseSqliteDB getInstance() {
    return this;
  }

  @override
  String create() {
    return "CREATE TABLE $tableName (" +
        "$columnCode TEXT PRIMARY KEY ," +
        "$columnName TEXT," +
        "$columnCodeKecamatan TEXT," +
        "$columnPostal TEXT" +
        ")";
  }

  @override
  String tableNames() {
    return tableName;
  }
}
