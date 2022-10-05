class ConfigModel {
  late String? labelConfig;
  late String? version;
  late bool? valueBool;
  late double? valueDouble;
  late String? valueString;
  late int? valueInt;

  ConfigModel(
      {this.labelConfig,
      this.version,
      this.valueBool,
      this.valueInt,
      this.valueDouble,
      this.valueString});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    labelConfig = json['label_config'];
    version = json['version'];
    valueBool = json['value_bool'];
    valueDouble = json['value_double'];
    valueInt = json['value_int'];
    valueString = json['value_string'];
  }
}

class BaseResponseConfig {
  late bool? status;
  late String? message;
  late List<ConfigModel?>? data;

  BaseResponseConfig({this.status, this.message, this.data});

  factory BaseResponseConfig.fromJson(Map<String, dynamic> json) =>
      BaseResponseConfig(
          status: json['status'],
          message: json['message'],
          data: (json['data'] as List)
              .map((e) => e == null
                  ? null
                  : ConfigModel.fromJson(e as Map<String, dynamic>))
              .toList());
}
