// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/feature/model/token/token.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/utils.dart';

class OnBoardController extends BaseController {
  late ThemeData theme;

  late ThemeController themeController;
  ApiRepository _apiRepository = ApiRepository();

  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();
    theme = themeController.getTheme();
    getToken();
    Future.delayed(const Duration(seconds: 5), () {
      // debugPrint("value ${sessionController.compCode!.value}");
      if (sessionController.name != null) {
        navigateNext();
      } else {
        Utils.offAndToNamed(name: AppRoutes.LOGINSCREEN);
      }
      Get.delete<OnBoardController>();
    });
  }

  void getToken() async {
    try {
      TokenModel result = await _apiRepository.postToken(data: {
        "grant_type": "client_credentials",
        "client_id": "test",
        "client_secret": "rahasia",
        "scope": "token"
      });

      if (result.accessToken != null) {
        sessionController.setAccessToken(result.accessToken);
      }

      // listPosts.addAll(data.postList);
      // tempPosts.addAll(data.postList);
      //   if (data != null) {
      //     listPosts.addAll(data);
      //     isToLoadMore = true;
      //     change(donors, status: RxStatus.success());
      //   } else {
      //     isToLoadMore = false;
      //   }
      // }
      //else {
      // isToLoadMore = false;

    } catch (e) {
      Utils.showSnackBar(text: "widih");
    }
  }

  void navigateNext() {
    switch (sessionController.roleId!.value) {
      case "1":
        Utils.offAndToNamed(name: AppRoutes.HOMESCREEN);
        break;
      case "3":
        Utils.offAndToNamed(name: AppRoutes.USERHOMESCREEN);
        break;
      default:
        Utils.offAndToNamed(name: AppRoutes.HOMESCREEN);
        break;
    }
  }
}
