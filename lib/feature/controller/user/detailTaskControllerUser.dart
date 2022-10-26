import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/model/order/order.dart';
import 'package:sitaris/feature/model/task/taskByDept.dart';
import 'package:sitaris/utils/enum.dart';
import 'package:sitaris/utils/shimmer/shimmerOrderUser.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/utils.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../themeController.dart';

class DetailTaskControllerUser extends BaseController {
  late ThemeData theme;
  late ThemeController themeController;
  late String productId;
  late String orderid;
  ApiRepository _apiRepository = ApiRepository();
  Rx<DetailTaskState> state = DetailTaskState.INITIAL.obs;
  String? errorTextOrder = "";
  RxList<TaskModel?> listTaskModel = <TaskModel?>[].obs;
  late OrderMasterModel orderMaster;

  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();
    theme = themeController.getTheme();
  }

  void getAllTask() async {
    state.value = DetailTaskState.LOADING;
    try {
      Map<String, dynamic> _dataForGet = {
        "prod_id": productId,
        "order_id": orderid
      };

      BaseResponseAllTask result =
          await _apiRepository.getTaskByProd(data: _dataForGet);

      // print(data.status);
      if (result.status! && result.data != null) {
        //20221007
        if (result.data!.length > 0) {
          listTaskModel.addAll(result.data!);
          state.value = DetailTaskState.LOADED;
        } else {
          state.value = DetailTaskState.EMPTY;
        }
      } else {
        errorTextOrder = result.message!;
        state.value = DetailTaskState.ERROR;
        // if (!result.status!) Utils.showSnackBar(text: result.message!);
      }
    } catch (e) {
      errorTextOrder = e.toString();
      state.value = DetailTaskState.ERROR;
      // Utils.showSnackBar(text: "$e");
    }
    return;
  }

  Widget getTimelineWidget() {
    switch (state.value) {
      case DetailTaskState.ERROR:
        return FxText.bodySmall(errorTextOrder!,
            letterSpacing: 0.3, fontWeight: 600, color: Colors.black);
      case DetailTaskState.LOADED:
        return _TimelineWidget();
      case DetailTaskState.INITIAL:
      case DetailTaskState.LOADING:
      default:
        return ShimmerOrderUser();
    }
  }

  Widget _TimelineWidget() {
    return ListView.builder(
      itemCount: listTaskModel.length,
      itemBuilder: (context, index) => TimelineTile(
        alignment: TimelineAlign.start,
        isFirst: index == 0,
        isLast: index == listTaskModel.length - 1,
        endChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getTimelineDue(listTaskModel[index]!.status!, index),
                FxText.labelMedium(listTaskModel[index]!.taskNm!,
                    color: Colors.black, fontWeight: 600),
                FxSpacing.height(5),
                _getTimelineComplete(index)
              ],
            ),
          ),
        ),
        afterLineStyle: _afterStyle(index),
        beforeLineStyle: _beforeStyle(index),
        indicatorStyle: IndicatorStyle(
            width: 40,
            height: 40,
            indicator: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: (listTaskModel[index]!.status == "DONE")
                        ? Colors.green
                        : Colors.red,
                    width: 4,
                  ),
                ),
              ),
              child: Center(
                child: Icon(
                  (listTaskModel[index]!.status == "DONE")
                      ? Icons.check
                      : Icons.cancel,
                  color: (listTaskModel[index]!.status == "DONE")
                      ? Colors.green
                      : Colors.red,
                  size: 20.0,
                ),
              ),
            ),
            drawGap: true),
      ),
    );
  }

  LineStyle _beforeStyle(index) {
    if (index == 0) {
      return LineStyle(
        color: (listTaskModel[index]!.status == "DONE")
            ? Colors.green
            : Colors.grey,
      );
    } else {
      if (index > 0) {
        return LineStyle(
          color: (listTaskModel[index - 1]!.status == "DONE")
              ? Colors.green
              : Colors.grey,
        );
      } else {
        return LineStyle(
          color: (listTaskModel[index]!.status == "DONE")
              ? Colors.green
              : Colors.grey,
        );
      }
    }
  }

  LineStyle _afterStyle(index) {
    if (index == 0) {
      return LineStyle(
        color: (listTaskModel[index]!.status == "DONE")
            ? Colors.green
            : Colors.grey,
      );
    } else {
      if (index < (listTaskModel.length - 1)) {
        return LineStyle(
          color: (listTaskModel[index + 1]!.status == "DONE")
              ? Colors.green
              : Colors.grey,
        );
      } else {
        return LineStyle(
          color: (listTaskModel[index]!.status == "DONE")
              ? Colors.green
              : Colors.grey,
        );
      }
    }
  }

  Widget _getTimelineComplete(int index) {
    if (listTaskModel[index]!.taskCompleteBy != null) {
      return FxText.labelMedium("PIC : ${listTaskModel[index]!.taskCompleteBy}",
          color: Colors.black, fontWeight: 600);
    } else {
      if (listTaskModel[index]!.deptId == sessionController.deptId!.value)
        return Container();
      else
        return FxText.labelMedium("Dept : ${listTaskModel[index]!.deptNm}",
            color: Colors.black, fontWeight: 600);
    }
  }

  String _checkDueDate(int index) {
    DateTime date = Utils.dateFormatDate(orderMaster.orderDt!);
    late DateTime dueDate;
    if (index == 0) {
      dueDate =
          date.add(Duration(days: int.parse(listTaskModel[index]!.mandays!)));
    } else {
      for (int i = 0; i <= index; i++) {
        if (listTaskModel[i]!.status == "DONE") {
          String dates = listTaskModel[i]!.mandays!.substring(0, 10);
          date =
              Utils.dateFormatDate(dates, explode: "-", needSubString: false);
        } else {
          date =
              date.add(Duration(days: int.parse(listTaskModel[i]!.mandays!)));
        }
      }
      dueDate = date;
    }

    return Utils.dateFormatToString(dueDate);
  }

  Widget _getTimelineDue(String status, int index) {
    switch (status) {
      case "DONE":
        return FxText.labelMedium(
            "Done - ${Utils.dateFormatToString(Utils.dateFormatDate(listTaskModel[index]!.mandays!.substring(0, 10), explode: "-", needSubString: false))}",
            color: Colors.black,
            fontWeight: 600);
      case "ACTIVE":
      case "NOT":
      default:
        return FxText.labelMedium("Due - ${_checkDueDate(index)}",
            color: Colors.black, fontWeight: 600);
    }
  }
}
