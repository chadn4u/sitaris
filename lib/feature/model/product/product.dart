import 'package:get/get.dart';

class ProductModel {
  late String? prodId;
  late String? prodNm;
  late List<FileTypeModel?>? files;

  bool selected = false;

  ProductModel({this.prodId, this.prodNm});

  ProductModel.fromJson(Map<String, dynamic> json) {
    prodId = json['prod_id'];
    prodNm = json['prod_nm'];
    files = (json['files'] != null)
        ? (json['files'] as List)
            .map((e) => e == null
                ? null
                : FileTypeModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : null;
  }
  Map<String, dynamic> toJson() =>
      {"prod_id": prodId, "prod_nm": prodNm, "files": files};
  @override
  String toString() {
    return "{prod_id:${prodId}, prod_nm:${prodNm}}";
  }
}

class FileTypeModel {
  late String? label;
  late String? type;
  late int? limit;

  RxList<Map<String, dynamic>>? data = RxList();

  FileTypeModel({this.label, this.type, this.limit});

  FileTypeModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    type = json['prod_nm'];
    limit = json['limit'];
  }
  Map<String, dynamic> toJson() => {
        "label": label,
        "type": type,
        "files": (data as List)
            .map((e) => e == null ? null : {"id": e["id"], "value": e["value"]})
            .toList()
      };
}

class BaseResponseProduct {
  late bool? status;
  late String? message;
  late List<ProductModel?>? data;

  BaseResponseProduct({this.status, this.message, this.data});

  factory BaseResponseProduct.fromJson(Map<String, dynamic> json) =>
      BaseResponseProduct(
          status: json['status'],
          message: json['message'],
          data: (json['data'] as List)
              .map((e) => e == null
                  ? null
                  : ProductModel.fromJson(e as Map<String, dynamic>))
              .toList());
}
