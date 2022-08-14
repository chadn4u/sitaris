// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/utils.dart';

class OnBoardController extends BaseController {
  late ThemeData theme;

  late ThemeController themeController;

  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();
    theme = themeController.getTheme();

    Future.delayed(const Duration(seconds: 5), () {
      // debugPrint("value ${sessionController.compCode!.value}");
      if (sessionController.compCode != null) {
        navigateNext();
      } else {
        Utils.offAndToNamed(name: AppRoutes.LOGINSCREEN);
      }
      Get.delete<OnBoardController>();
    });
  }

  void navigateNext() {
    switch (sessionController.lvlLog!.value) {
      case "staffin":
        Utils.offAndToNamed(name: AppRoutes.HOMESCREEN);
        break;
      case "partner":
        Utils.offAndToNamed(name: AppRoutes.USERHOMESCREEN);
        break;
      default:
        Utils.offAndToNamed(name: AppRoutes.HOMESCREEN);
        break;
    }
  }
}
