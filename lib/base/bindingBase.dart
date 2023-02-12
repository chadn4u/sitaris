// ignore_for_file: file_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/firebaseController.dart';
import 'package:sitaris/feature/controller/sessionController.dart';
import 'package:sitaris/feature/controller/themeController.dart';

import '../core/network/rest_client.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<SessionController>(() => SessionController());
    initRest();
    // Get.lazyPut<AppBarController>(() => AppBarController());
    // Get.lazyPut<MenuController>(() => MenuController());
    // Get.lazyPut<DataGridsController>(() => DataGridsController());
  }

  void initRest() async {
    await Get.putAsync<RestClient>(() => RestClient().init());
    await Get.put(FirebaseController());
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        Get.find<FirebaseController>().remoteMessage = message;
        // _firebaseMessageProvider.remoteMessageset = message;
        // _firebaseMessageProvider.isNotifset = true;
      }
    });
  }
}
