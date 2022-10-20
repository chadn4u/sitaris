import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/model/order/order.dart';
import 'package:sitaris/utils/button.dart';
import 'package:sitaris/utils/spacing.dart';

import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/utils.dart';
import 'package:timelines/timelines.dart';

class DetailTaskPage extends StatefulWidget {
  const DetailTaskPage({super.key});

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  bool isEdgeIndex(int index) {
    return index == 0; //|| index == messages.length + 1;
  }

  late OrderMasterModel orderMasterModel;
  late OrderDetailModel product;
  late String taskTitle;

  @override
  void initState() {
    super.initState();
    orderMasterModel = Get.arguments["order"];
    product = Get.arguments["product"];
    taskTitle = Get.arguments["tasktitle"];
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              height: Utils.dynamicHeight(30),
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
                  FxText.titleSmall("Debitur: ${orderMasterModel.orderCustNm}",
                      fontWeight: 600, color: Colors.white),
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
                child: Timeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: 0,
                    connectorTheme: ConnectorThemeData(
                      thickness: 3.0,
                      color: Color(0xffd3d3d3),
                    ),
                    indicatorTheme: IndicatorThemeData(
                      size: 15.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  builder: TimelineTileBuilder.connected(
                    contentsBuilder: (_, __) => Container(
                      margin: EdgeInsets.only(left: 10.0),
                      height: Utils.dynamicHeight(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0)),
                      child: product.tasks![__]!.taskNm! == taskTitle
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxText.labelMedium(product.tasks![__]!.taskNm!,
                                    color: Colors.black, fontWeight: 600),
                                FxSpacing.height(10),
                                Row(
                                  children: [
                                    FxButton.medium(
                                      onPressed: () {},
                                      backgroundColor: Colors.green,
                                      child: FxText.bodyMedium("Retry",
                                          color: Colors.white,
                                          fontWeight: 400,
                                          muted: true),
                                      buttonType: FxButtonType.elevated,
                                    )
                                  ],
                                )
                              ],
                            )
                          : Container(),
                    ),
                    connectorBuilder: (_, index, __) {
                      if (index == 0) {
                        return SolidLineConnector(color: Color(0xff6ad192));
                      } else {
                        return SolidLineConnector();
                      }
                    },
                    indicatorBuilder: (_, index) {
                      // switch (data[index]) {
                      //   case _TimelineStatus.done:
                      return DotIndicator(
                        color: Color(0xff6ad192),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 10.0,
                        ),
                      );
                      // case _TimelineStatus.sync:
                      //   return DotIndicator(
                      //     color: Color(0xff193fcc),
                      //     child: Icon(
                      //       Icons.sync,
                      //       size: 10.0,
                      //       color: Colors.white,
                      //     ),
                      //   );
                      // case _TimelineStatus.inProgress:
                      //   return OutlinedDotIndicator(
                      //     color: Color(0xffa7842a),
                      //     borderWidth: 2.0,
                      //     backgroundColor: Color(0xffebcb62),
                      //   );
                      // case _TimelineStatus.todo:
                      // default:
                      //   return OutlinedDotIndicator(
                      //     color: Color(0xffbabdc0),
                      //     backgroundColor: Color(0xffe6e7e9),
                      //   );
                      // }
                    },
                    itemExtentBuilder: (_, __) => Utils.dynamicHeight(20),
                    itemCount: product.tasks!.length,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
