import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/staff/detailTaskController.dart';
import 'package:sitaris/feature/model/order/order.dart';
import 'package:sitaris/utils/spacing.dart';

import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/utils.dart';
// import 'package:timelines/timelines.dart';

class DetailTaskPage extends StatefulWidget {
  const DetailTaskPage({super.key});

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  late DetailTaskController controller;

  late OrderMasterModel orderMasterModel;
  late OrderDetailModel product;
  late String taskTitle;

  @override
  void initState() {
    super.initState();
    orderMasterModel = Get.arguments["order"];
    product = Get.arguments["product"];
    taskTitle = Get.arguments["tasktitle"];

    controller = Get.put(DetailTaskController());
    controller.orderMaster = orderMasterModel;
    controller.productId = product.prodId!;
    controller.orderid = orderMasterModel.orderId!;
    debugPrint(controller.productId);
    controller.getAllTask();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<DetailTaskController>();
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


// Timeline.tileBuilder(
//                     theme: TimelineThemeData(
//                       nodePosition: 0,
//                       connectorTheme: ConnectorThemeData(
//                         thickness: 3.0,
//                         color: Color(0xffd3d3d3),
//                       ),
//                       indicatorTheme: IndicatorThemeData(
//                         size: 15.0,
//                       ),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 5.0),
//                     builder: TimelineTileBuilder.connected(
//                       contentsBuilder: (_, __) => Container(
//                         margin: EdgeInsets.fromLTRB(10.0, 0.0, 0, 0),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(2.0)),
//                         child: controller.listTaskModel[__]!.taskNm! ==
//                                 taskTitle
//                             ? Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   FxText.labelMedium(
//                                       controller.listTaskModel[__]!.taskNm!,
//                                       color: Colors.black,
//                                       fontWeight: 600),
//                                   FxSpacing.height(5),
//                                   Row(
//                                     children: [
//                                       FxButton.small(
//                                         onPressed: () {
//                                           Get.dialog(
//                                                   Center(
//                                                     child: Container(
//                                                       width: Utils.dynamicWidth(
//                                                           70),
//                                                       height:
//                                                           Utils.dynamicHeight(
//                                                               15),
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       color: Colors.white,
//                                                       child: Column(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             Icon(
//                                                               Icons.check,
//                                                               color:
//                                                                   Colors.green,
//                                                               size: 45,
//                                                             ),
//                                                             FxSpacing.height(
//                                                                 10),
//                                                             FxText.bodyMedium(
//                                                                 'Task berhasil di update')
//                                                           ]),
//                                                     ),
//                                                   ),
//                                                   barrierDismissible: true,
//                                                   barrierColor: Colors.grey
//                                                       .withOpacity(0.3))
//                                               .then((value) =>
//                                                   Utils.navigateBack());
//                                         },
//                                         backgroundColor: Colors.green,
//                                         child: FxText.bodyMedium("Submit",
//                                             color: Colors.white,
//                                             fontWeight: 400,
//                                             muted: true),
//                                         buttonType: FxButtonType.elevated,
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               )
//                             : FxText.labelMedium(
//                                 controller.listTaskModel[__]!.taskNm!,
//                                 color: Colors.black,
//                                 fontWeight: 600),
//                       ),
//                       connectorBuilder: (_, index, __) {
//                         if (index == 0) {
//                           return SolidLineConnector(color: Color(0xff6ad192));
//                         } else {
//                           return SolidLineConnector(color: Colors.grey);
//                         }
//                       },
//                       indicatorBuilder: (_, index) {
//                         // switch (data[index]) {
//                         //   case _TimelineStatus.done:
//                         if (index == 0)
//                           return DotIndicator(
//                             color: Color(0xff6ad192),
//                             child: Icon(
//                               Icons.check,
//                               color: Colors.white,
//                               size: 10.0,
//                             ),
//                           );
//                         else
//                           return DotIndicator(
//                             color: Color.fromARGB(255, 235, 29, 29),
//                             child: Icon(
//                               Icons.close,
//                               color: Colors.white,
//                               size: 10.0,
//                             ),
//                           );
//                         // case _TimelineStatus.sync:
//                         //   return DotIndicator(
//                         //     color: Color(0xff193fcc),
//                         //     child: Icon(
//                         //       Icons.sync,
//                         //       size: 10.0,
//                         //       color: Colors.white,
//                         //     ),
//                         //   );
//                         // case _TimelineStatus.inProgress:
//                         //   return OutlinedDotIndicator(
//                         //     color: Color(0xffa7842a),
//                         //     borderWidth: 2.0,
//                         //     backgroundColor: Color(0xffebcb62),
//                         //   );
//                         // case _TimelineStatus.todo:
//                         // default:
//                         //   return OutlinedDotIndicator(
//                         //     color: Color(0xffbabdc0),
//                         //     backgroundColor: Color(0xffe6e7e9),
//                         //   );
//                         // }
//                       },
//                       itemExtentBuilder: (_, __) => Utils.dynamicHeight(15),
//                       itemCount: controller.listTaskModel.length,
//                     ),
//                   )