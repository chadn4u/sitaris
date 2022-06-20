import 'package:get/get.dart';
import 'package:sitaris/feature/controller/loginController.dart';
import 'package:sitaris/feature/controller/themeController.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ThemeController>(() => ThemeController());
    // Get.lazyPut<AppBarController>(() => AppBarController());
    // Get.lazyPut<MenuController>(() => MenuController());
    // Get.lazyPut<DataGridsController>(() => DataGridsController());
  }
}
