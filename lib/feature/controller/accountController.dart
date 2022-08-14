// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/feature/controller/homeController.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/utils.dart';

import 'themeController.dart';

class AccountController extends BaseController {
  late ThemeData theme;
  late ThemeController themeController;
  RxBool passwordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();
    theme = themeController.getTheme();
  }

  void logout() {
    sessionController.clearSession();
    Utils.offAndToNamed(name: AppRoutes.LOGINSCREEN);
    Get.delete<AccountController>();
    Get.delete<HomeController>();
  }
}
