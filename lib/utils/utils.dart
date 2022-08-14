import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static void navigateBack(
      {BuildContext? context,
      String? until,
      bool closeOverlay = false,
      String? result}) {
    // Navigator.pop(context);

    Get.back(result: result, closeOverlays: closeOverlay);
  }

  static Future<dynamic>? navigateTo(
      {BuildContext? context, required String name, dynamic args}) {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => widget,
    //     ));
    return Get.toNamed(name, arguments: args, preventDuplicates: true);
  }

  static Future<dynamic>? offAndToNamed(
      {BuildContext? context, required String name, dynamic args}) {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => widget,
    //     ));
    return Get.offAndToNamed(
      name,
      arguments: args,
    );
  }

  static void showSnackBar({required String text}) {
    Get.showSnackbar(GetSnackBar(
      isDismissible: true,
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: Colors.red,
      message: text,
      snackPosition: SnackPosition.BOTTOM,
    ));
  }
}
