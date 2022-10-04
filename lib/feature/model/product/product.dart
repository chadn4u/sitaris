class ProductModel {
  late String? prodId;
  late String? prodNm;
  late List<FileTypeModel?> files;

  ProductModel({this.prodId, this.prodNm});

  ProductModel.fromJson(Map<String, dynamic> json) {
    prodId = json['prod_id'];
    prodNm = json['prod_nm'];
    files = (json['files'] as List)
        .map((e) => e == null
            ? null
            : FileTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class FileTypeModel {
  late String? label;
  late String? type;

  FileTypeModel({this.label, this.type});

  FileTypeModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    type = json['prod_nm'];
  }
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