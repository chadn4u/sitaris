class ProvinceTable {
  static final String tableName = 'mst_province';
  static final String columnCode = 'province_code';
  static final String columnName = 'province_name';

  late String? provinceCode;
  late String? provinceName;

  ProvinceTable({String? code, String? name}) {
    provinceCode = code;
    provinceName = name;
  }

  Map<String, dynamic> toJson() =>
      {columnCode: provinceCode, columnName: provinceName};

  static List<ProvinceTable> fromJsonList(List<dynamic> json) =>
      json.map((i) => ProvinceTable.fromJson(i)).toList();

  ProvinceTable.fromJson(Map<String, dynamic> json) {
    provinceCode = json[columnCode];
    provinceName = json[columnName];
  }

  static String create() {
    return "CREATE TABLE $tableName (" +
        "$columnCode TEXT PRIMARY KEY ," +
        "$columnName TEXT" +
        ")";
  }
}
