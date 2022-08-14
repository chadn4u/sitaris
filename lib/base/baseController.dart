// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:sitaris/feature/controller/sessionController.dart';

import '../core/network/rest_client.dart';

class BaseController extends GetxController {
  late RestClient restClient;
  late SessionController sessionController;

  @override
  onInit() {
    super.onInit();
    restClient = Get.find();
    sessionController = Get.find();
  }
}
