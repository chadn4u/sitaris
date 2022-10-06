class OrderPresetModel {
  late String? orderNo;
  late String? orderDt;

  OrderPresetModel({this.orderNo, this.orderDt});

  OrderPresetModel.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderno'];
    orderDt = json['orderdt'];
  }
}

class BaseResponseOrderPreset {
  late bool? status;
  late String? message;
  late OrderPresetModel? data;

  BaseResponseOrderPreset({this.status, this.message, this.data});

  factory BaseResponseOrderPreset.fromJson(Map<String, dynamic> json) =>
      BaseResponseOrderPreset(
          status: json['status'],
          message: json['message'],
          data: (json['data'] == null)
              ? null
              : OrderPresetModel.fromJson(json['data']));
}
