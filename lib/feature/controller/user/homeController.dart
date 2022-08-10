import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themeController.dart';

class HomeController extends GetxController {
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
}
