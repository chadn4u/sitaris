import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'themeController.dart';

class AccountController extends GetxController {
  late ThemeData theme;
  late ThemeController themeController;
  RxBool passwordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();
    theme = themeController.getTheme();
  }
}
