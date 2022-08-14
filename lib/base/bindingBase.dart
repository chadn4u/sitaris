// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:sitaris/feature/controller/sessionController.dart';
import 'package:sitaris/feature/controller/themeController.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<SessionController>(() => SessionController());
    // Get.lazyPut<AppBarController>(() => AppBarController());
    // Get.lazyPut<MenuController>(() => MenuController());
    // Get.lazyPut<DataGridsController>(() => DataGridsController());
  }
}
