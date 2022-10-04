// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/core/sqlite/province/province.dart';
import 'package:sitaris/core/sqlite/province/provinceDao.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/feature/model/city/city.dart';
import 'package:sitaris/feature/model/kecamatan/kecamatan.dart';
import 'package:sitaris/feature/model/kelurahan/kelurahan.dart';
import 'package:sitaris/feature/model/province/province.dart';
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
    getProvince();
    getCity();
    getKecamatan();
    getKelurahan().then((value) {
// debugPrint("value ${sessionController.compCode!.value}");
      if (sessionController.name != null) {
        navigateNext();
      } else {
        Utils.offAndToNamed(name: AppRoutes.LOGINSCREEN);
      }
      Get.delete<OnBoardController>();
    });
    // Future.delayed(const Duration(seconds: 5), () {

    // });
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

  void getProvince() async {
    try {
      BaseResponseProvince result = await _apiRepository.getProvince();

      if (result.data != null) {
        ProvinceDAO dao = new ProvinceDAO();
        dao.getDbInstance().then((value) {
          result.data!.forEach((element) {
            ProvinceTable provinceTable = ProvinceTable(
                code: element!.provinceCode, name: element.provinceName);

            dao.insert(provinceTable);
          });
        });
      }
    } catch (e) {
      Utils.showSnackBar(text: "widih");
    }
  }

  void getCity() async {
    try {
      BaseResponseCity result = await _apiRepository.getCity();

      // if (result.accessToken != null) {
      //   sessionController.setAccessToken(result.accessToken);
      // }

    } catch (e) {
      Utils.showSnackBar(text: "widih");
    }
  }

  void getKecamatan() async {
    try {
      BaseResponseKecamatan result = await _apiRepository.getKecamatan();

      // if (result.accessToken != null) {
      //   sessionController.setAccessToken(result.accessToken);
      // }

    } catch (e) {
      Utils.showSnackBar(text: "widih");
    }
  }

  Future<void> getKelurahan() async {
    try {
      BaseResponseKelurahan result = await _apiRepository.getKelurahan();

      // if (result.accessToken != null) {
      //   sessionController.setAccessToken(result.accessToken);
      // }

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
