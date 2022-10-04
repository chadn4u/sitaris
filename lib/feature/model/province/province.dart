class ProvinceModel {
  late String? provinceCode;
  late String? provinceName;

  ProvinceModel({this.provinceCode, this.provinceName});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    provinceCode = json['province_code'];
    provinceName = json['province_name'];
  }
}

class BaseResponseProvince {
  late bool? status;
  late String? message;
  late List<ProvinceModel?>? data;

  BaseResponseProvince({this.status, this.message, this.data});

  factory BaseResponseProvince.fromJson(Map<String, dynamic> json) =>
      BaseResponseProvince(
          status: json['status'],
          message: json['message'],
          data: (json['data'] as List)
              .map((e) => e == null
                  ? null
                  : ProvinceModel.fromJson(e as Map<String, dynamic>))
              .toList());
}
