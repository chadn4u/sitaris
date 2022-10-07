class KonsumenModel {
  late String? bankId;
  late String? bankNm;
  late String? bankPic;
  late String? bankAddr1;
  late String? bankAddr2;
  late String? bankCity;

  KonsumenModel(
      {this.bankId,
      this.bankNm,
      this.bankPic,
      this.bankAddr1,
      this.bankAddr2,
      this.bankCity});

  KonsumenModel.fromJson(Map<String, dynamic> json) {
    bankId = json['bank_id'];
    bankNm = json['bank_nm'];
    bankPic = json['bank_pic'];

    bankAddr1 = json['bank_addr1'];
    bankAddr2 = json['bank_addr2'];
    bankCity = json['bank_city'];
  }
}

class BaseResponseKonsumen {
  late bool? status;
  late String? message;
  late List<KonsumenModel?>? data;

  BaseResponseKonsumen({this.status, this.message, this.data});

  factory BaseResponseKonsumen.fromJson(Map<String, dynamic> json) =>
      BaseResponseKonsumen(
          status: json['status'],
          message: json['message'],
          data: (json['data'] as List)
              .map((e) => e == null
                  ? null
                  : KonsumenModel.fromJson(e as Map<String, dynamic>))
              .toList());
}
