import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sitaris/utils/customIcon.dart';

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

  static IconData getIcon(String id) {
    switch (id) {
      case "31":
        return FFIcons.k012Notary;
      case "11":
        return FFIcons.k001Law;
      case "14":
        return FFIcons.k002Global;
      default:
        return Icons.more_horiz_outlined;
    }
  }

  static double dynamicWidth(double val) {
    // double percentage = MediaQuery.of(Get.context).size.width * val;
    // return ScreenUtil().setWidth(val.w);
    // if (SizerUtil.deviceType == DeviceType.tablet)
    //   return MediaQuery.of(Get.context).size.width * (val / 100);
    // else
    return MediaQuery.of(Get.context!).size.width * (val / 100);
  }

  static double dynamicHeight(double val) {
    // double percentage = MediaQuery.of(Get.context).size.height * val;
    // return ScreenUtil().setHeight(val.h);
    // if (SizerUtil.deviceType == DeviceType.tablet) {
    //   return MediaQuery.of(Get.context).size.height * (val / 100);
    // } else
    return MediaQuery.of(Get.context!).size.height * (val / 100);
  }

  static String dateFormat(String date) {
    final fFormat = new DateFormat('dd-MMM-yyyy');
    final f = new DateFormat('yyyy-MM-dd');
    final formattedDate =
        "${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}";
    return fFormat.format(f.parse(formattedDate));
  }

  // static double dynamicFont(double val) {
  //   if (SizerUtil.deviceType == DeviceType.tablet) {
  //     return val * 1.5;
  //   } else {
  //     return ScreenUtil().setSp(val);
  //   }
  //   // return val.sp;
  // }
}
