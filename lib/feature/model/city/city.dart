class CityModel {
  late String? city;
  late String? cityCode;
  late String? provinceCode;

  CityModel({this.city, this.cityCode, this.provinceCode});

  CityModel.fromJson(Map<String, dynamic> json) {
    provinceCode = json['province_code'];
    city = json['city'];
    cityCode = json['city_code'];
  }
}

class BaseResponseCity {
  late bool? status;
  late String? message;
  late List<CityModel?>? data;

  BaseResponseCity({this.status, this.message, this.data});

  factory BaseResponseCity.fromJson(Map<String, dynamic> json) =>
      BaseResponseCity(
          status: json['status'],
          message: json['message'],
          data: (json['data'] as List)
              .map((e) => e == null
                  ? null
                  : CityModel.fromJson(e as Map<String, dynamic>))
              .toList());
}
