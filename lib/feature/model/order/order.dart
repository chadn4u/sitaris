class BaseResponseOrder {
  late bool? status;
  late String? message;
  late List<OrderMasterModel?>? data;

  BaseResponseOrder({this.status, this.message, this.data});

  factory BaseResponseOrder.fromJson(Map<String, dynamic> json) =>
      BaseResponseOrder(
          status: json['status'],
          message: json['message'],
          data: json['data'] == null
              ? null
              : (json['data'] as List)
                  .map((e) => e == null
                      ? null
                      : OrderMasterModel.fromJson(e as Map<String, dynamic>))
                  .toList());
}

class OrderMasterModel {
  late String? orderId;
  late String? orderDt;
  late String? bankId;
  late String? bankNm;
  late String? orderCustNm;
  late String? orderCustaddr;
  late String? statusId;
  late String? statusNm;
  late String? lastUpdateDt;
  late List<OrderDetailModel?>? orderDetail;

  OrderMasterModel({
    this.orderId,
    this.orderDt,
    this.bankId,
    this.bankNm,
    this.orderCustNm,
    this.orderCustaddr,
    this.statusId,
    this.statusNm,
    this.lastUpdateDt,
    this.orderDetail,
  });

  OrderMasterModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderDt = json['order_dt'];
    bankId = json['bank_id'];
    bankNm = json['bankNm'];
    orderCustNm = json['order_cust_nm'];
    orderCustaddr = json['order_cust_addr'];
    statusId = json['status_id'];
    statusNm = json['status_nm'];
    lastUpdateDt = json['last_update_dt'];
    orderDetail = (json['order_detail'] as List)
        .map((e) => e == null
            ? null
            : OrderDetailModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class OrderDetailModel {
  late String? orderChildId;
  late String? seq;
  late String? prodId;
  late String? prodNm;
  late List<TaskModel?>? tasks;

  OrderDetailModel({
    this.orderChildId,
    this.seq,
    this.prodId,
    this.prodNm,
    this.tasks,
  });

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    orderChildId = json['order_child_id'];
    seq = json['seq'];
    prodId = json['prod_id'];
    prodNm = json['prod_nm'];
    tasks = (json['tasks'] as List)
        .map((e) =>
            e == null ? null : TaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class TaskModel {
  late String? taskId;
  late String? taskNm;
  late String? mandays;
  late String? startcnt;
  late String? deptId;
  late String? deptNm;

  TaskModel(
      {this.taskId,
      this.taskNm,
      this.mandays,
      this.startcnt,
      this.deptId,
      this.deptNm});

  TaskModel.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskNm = json['task_nm'];
    mandays = json['mandays'];
    startcnt = json['startcnt'];
    deptId = json['dept_id'];
    deptNm = json['dept_nm'];
  }
}
