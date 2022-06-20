import 'package:get/get.dart';
import 'package:sitaris/feature/controller/loginController.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    // Get.lazyPut<AppBarController>(() => AppBarController());
    // Get.lazyPut<MenuController>(() => MenuController());
    // Get.lazyPut<DataGridsController>(() => DataGridsController());
  }
}
