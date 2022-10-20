import '../order/order.dart';

class BaseResponseTaskByDept {
  late bool? status;
  late String? message;
  late List<ListTask?>? data;

  BaseResponseTaskByDept({this.status, this.message, this.data});

  factory BaseResponseTaskByDept.fromJson(Map<String, dynamic> json) =>
      BaseResponseTaskByDept(
          status: json['status'],
          message: json['message'],
          data: json['data'] == null
              ? null
              : (json['data'] as List)
                  .map((e) => e == null
                      ? null
                      : ListTask.fromJson(e as Map<String, dynamic>))
                  .toList());
}

class ListTask {
  late String? taskHead;
  late List<OrderMasterModel?>? orders;

  ListTask({
    this.taskHead,
    this.orders,
  });

  ListTask.fromJson(Map<String, dynamic> json) {
    taskHead = json['task_head'];
    orders = json['orders'] == null
        ? null
        : (json['orders'] as List)
            .map((e) => e == null
                ? null
                : OrderMasterModel.fromJson(e as Map<String, dynamic>))
            .toList();
  }
}
