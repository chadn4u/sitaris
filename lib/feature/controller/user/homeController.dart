// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/utils.dart';

import '../themeController.dart';

class HomeController extends BaseController {
  late ThemeData theme;
  late ThemeController themeController;

  // late List<Map<String, dynamic>> dummy;
  // late List<Map<String, dynamic>> dummyList;

  // ScrollController scrollController = ScrollController();
  // late TabController tabController;
  // RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();

    theme = themeController.getTheme();
  }

  void logout() {
    sessionController.clearSession();
    Utils.offAndToNamed(name: AppRoutes.LOGINSCREEN);
    // Get.delete<AccountController>();
    Get.delete<HomeController>();
  }
}
