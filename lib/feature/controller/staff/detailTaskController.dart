// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/model/order/order.dart';
import 'package:sitaris/feature/model/task/taskByDept.dart';
import 'package:sitaris/utils/enum.dart';

import '../themeController.dart';

class DetailTaskController extends BaseController {
  late ThemeData theme;
  late ThemeController themeController;
  late String productId;
  ApiRepository _apiRepository = ApiRepository();
  Rx<DetailTaskState> state = DetailTaskState.INITIAL.obs;
  String? errorTextOrder = "";
  RxList<TaskModel?> listTaskModel = RxList();

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
}
