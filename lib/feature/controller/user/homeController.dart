// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/model/product/product.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/utils.dart';

import '../../../utils/customIcon.dart';
import '../themeController.dart';

class HomeController extends BaseController {
  late ThemeData theme;
  late ThemeController themeController;
  ApiRepository _apiRepository = ApiRepository();
  RxList<ProductModel?> listDataProduct = <ProductModel?>[].obs;
  RxList<ProductModel?> listMenu = <ProductModel?>[].obs;

  // late List<Map<String, dynamic>> dummy;
  // late List<Map<String, dynamic>> dummyList;

  // ScrollController scrollController = ScrollController();
  // late TabController tabController;
  // RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();
    getProduct();

    theme = themeController.getTheme();
  }

  void getProduct() async {
    // try {
    BaseResponseProduct result = await _apiRepository.postProducts();

    // print(data.status);
    if (result.status!) {
      listDataProduct.value = result.data!;
      listMenu.add(listDataProduct[0]);
      listMenu.add(listDataProduct[1]);
      listMenu.add(listDataProduct[2]);
      listMenu.add(ProductModel(prodId: "0", prodNm: "More"));
      debugPrint("sukses");
    } else {
      Utils.showSnackBar(text: result.message!);
    }
    // } catch (e) {
    //   Utils.showSnackBar(text: "$e");
    // }
  }

  void logout() {
    sessionController.clearSession();
    Utils.offAndToNamed(name: AppRoutes.LOGINSCREEN);
    // Get.delete<AccountController>();
    Get.delete<HomeController>();
  }

  IconData getIcon(String id) {
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
}
