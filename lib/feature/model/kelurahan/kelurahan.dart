class KelurahanModel {
  late String? kelurahanCode;
  late String? kelurahan;
  late String? kecamatanCode;
  late String? postalCode;

  KelurahanModel(
      {this.kelurahanCode,
      this.kelurahan,
      this.kecamatanCode,
      this.postalCode});

  KelurahanModel.fromJson(Map<String, dynamic> json) {
    kelurahanCode = json['kelurahan_code'];
    kelurahan = json['kelurahan'];
    kecamatanCode = json['kecamatan_code'];
    postalCode = json['postal_code'];
  }
}

class BaseResponseKelurahan {
  late bool? status;
  late String? message;
  late List<KelurahanModel?>? data;

  BaseResponseKelurahan({this.status, this.message, this.data});

  factory BaseResponseKelurahan.fromJson(Map<String, dynamic> json) =>
      BaseResponseKelurahan(
          status: json['status'],
          message: json['message'],
          data: (json['data'] as List)
              .map((e) => e == null
                  ? null
                  : KelurahanModel.fromJson(e as Map<String, dynamic>))
              .toList());
}
