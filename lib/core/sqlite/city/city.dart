import 'package:sitaris/base/baseSqliteDB.dart';

class CityTable with BaseSqliteDB {
  static final String tableName = 'mst_city';
  static final String columnCode = 'city_code';
  static final String columnCodeProvince = 'province_code';
  static final String columnName = 'city';

  late String? cityCode;
  late String? cityName;
  late String? provinceCode;

  CityTable({String? codeProvince, String? name, String? cityCodes}) {
    provinceCode = codeProvince;
    cityName = name;
    cityCode = cityCodes;
  }

  Map<String, dynamic> toJson() => {
        columnCode: cityCode,
        columnName: cityName,
        columnCodeProvince: provinceCode
      };

  static List<CityTable> fromJsonList(List<dynamic> json) =>
      json.map((i) => CityTable.fromJson(i)).toList();

  CityTable.fromJson(Map<String, dynamic> json) {
    provinceCode = json[columnCodeProvince];
    cityName = json[columnName];
    cityCode = json[columnCode];
  }

  BaseSqliteDB getInstance() {
    return this;
  }

  @override
  String create() {
    return "CREATE TABLE $tableName (" +
        "$columnCode TEXT PRIMARY KEY ," +
        "$columnName TEXT," +
        "$columnCodeProvince TEXT" +
        ")";
  }

  @override
  String tableNames() {
    return tableName;
  }
}
