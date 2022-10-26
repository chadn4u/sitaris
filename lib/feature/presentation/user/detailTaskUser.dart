import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/user/detailTaskControllerUser.dart';
import 'package:sitaris/feature/model/order/order.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/utils.dart';

class DetailTaskUserPage extends StatefulWidget {
  const DetailTaskUserPage({super.key});

  @override
  State<DetailTaskUserPage> createState() => _DetailTaskUserPageState();
}

class _DetailTaskUserPageState extends State<DetailTaskUserPage> {
  late DetailTaskControllerUser controller;

  late OrderMasterModel orderMasterModel;
  late OrderDetailModel product;
  late String taskTitle;

  @override
  void initState() {
    super.initState();
    orderMasterModel = Get.arguments["order"];
    product = Get.arguments["product"];
    taskTitle = Get.arguments["tasktitle"];

    controller = Get.put(DetailTaskControllerUser());
    controller.orderMaster = orderMasterModel;
    controller.productId = product.prodId!;
    controller.orderid = orderMasterModel.orderId!;
    debugPrint(controller.productId);
    controller.getAllTask();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<DetailTaskControllerUser>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD3AB2B),
        elevation: 0,
        title: FxText.bodyLarge('Detail Task',
            color: Colors.white, fontWeight: 600),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                width: Utils.dynamicWidth(70),
                decoration: BoxDecoration(
                    color: Color(0xFFD3AB2B),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.bodyLarge("No. Order: #${orderMasterModel.orderNo} ",
                        color: Colors.white, fontWeight: 600),
                    FxSpacing.height(20),
                    FxText.titleSmall(
                        "Debitur: ${orderMasterModel.orderCustNm}",
                        fontWeight: 600,
                        color: Colors.white),
                    FxSpacing.height(10),
                    FxText.titleSmall("Product: ${product.prodNm}",
                        fontWeight: 600, color: Colors.white),
                    FxSpacing.height(10),
                    FxText.titleSmall(
                        "Tanggal Order: ${Utils.dateFormat(orderMasterModel.orderDt!)}",
                        fontWeight: 600,
                        color: Colors.white),
                    FxSpacing.height(20),
                    FxText.bodyLarge("Progress terakhir: $taskTitle ",
                        color: Colors.white, fontWeight: 600),
                  ],
                ),
              ),
            ),
            Container(
              height: Utils.dynamicHeight(60),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: controller.getTimelineWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
