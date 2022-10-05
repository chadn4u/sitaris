import 'package:sitaris/base/baseSqliteDB.dart';

class ConfigTable with BaseSqliteDB {
  static final String tableName = 'mst_config';
  static final String columnCode = 'label_config';
  static final String columnVersion = 'version';
  static final String columnBool = 'value_bool';
  static final String columnDouble = 'value_double';
  static final String columnString = 'value_string';
  static final String columnInt = 'value_int';

  late String? labelConfig;
  late String? version;
  late bool? valueBool;
  late double? valueDouble;
  late String? valueString;
  late int? valueInt;

  ConfigTable(
      {String? label,
      String? versions,
      bool? valueBools,
      double? valueDoubles,
      String? valueStrings,
      int? valueInts}) {
    labelConfig = label;
    version = versions;
    valueBool = valueBools;
    valueDouble = valueDoubles;
    valueString = valueStrings;
    valueInt = valueInts;
  }

  Map<String, dynamic> toJson() => {
        columnCode: labelConfig,
        columnVersion: version,
        columnBool: valueBool,
        columnDouble: valueDouble,
        columnString: valueString,
        columnInt: valueInt
      };

  static List<ConfigTable> fromJsonList(List<dynamic> json) =>
      json.map((i) => ConfigTable.fromJson(i)).toList();

  ConfigTable.fromJson(Map<String, dynamic> json) {
    labelConfig = json[columnCode];
    version = json[columnVersion];
    valueBool = json[columnBool];
    valueDouble = json[columnDouble];
    valueString = json[columnString];
    valueInt = json[columnInt];
  }

  BaseSqliteDB getInstance() {
    return this;
  }

  @override
  String create() {
    return "CREATE TABLE $tableName (" +
        "$columnCode TEXT PRIMARY KEY ," +
        "$columnVersion TEXT," +
        "$columnBool TINYINT(4)," +
        "$columnDouble FLOAT," +
        "$columnString TEXT," +
        "$columnInt INT(11)" +
        ")";
  }

  @override
  String tableNames() {
    return tableName;
  }
}
