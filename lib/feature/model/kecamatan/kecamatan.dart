class KecamatanModel {
  late String? cityCode;
  late String? kecamatan;
  late String? kecamatanCode;

  KecamatanModel({this.cityCode, this.kecamatan, this.kecamatanCode});

  KecamatanModel.fromJson(Map<String, dynamic> json) {
    cityCode = json['city_code'];
    kecamatan = json['kecamatan'];
    kecamatanCode = json['kecamatan_code'];
  }
}

class BaseResponseKecamatan {
  late bool? status;
  late String? message;
  late List<KecamatanModel?>? data;

  BaseResponseKecamatan({this.status, this.message, this.data});

  factory BaseResponseKecamatan.fromJson(Map<String, dynamic> json) =>
      BaseResponseKecamatan(
          status: json['status'],
          message: json['message'],
          data: (json['data'] as List)
              .map((e) => e == null
                  ? null
                  : KecamatanModel.fromJson(e as Map<String, dynamic>))
              .toList());
}
