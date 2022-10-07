// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/model/order/order.dart';
import 'package:sitaris/feature/model/product/product.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/utils.dart';
import '../../presentation/user/home.dart';
import '../themeController.dart';

class HomeController extends BaseController {
  late ThemeData theme;
  late ThemeController themeController;

  PageController? pageController;
  ApiRepository _apiRepository = ApiRepository();
  RxList<ProductModel?> listDataProduct = <ProductModel?>[].obs;
  RxList<ProductModel?> listMenu = <ProductModel?>[].obs;
  late BuildContext ctx;
  RxList<OrderMasterModel?> orderMasterModel = <OrderMasterModel?>[].obs;

  // late List<Map<String, dynamic>> dummy;
  // late List<Map<String, dynamic>> dummyList;

  // ScrollController scrollController = ScrollController();
  // late TabController tabController;
  // RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    pageController = PageController();
    themeController = Get.find<ThemeController>();
    getProduct();
    getOrder();

    theme = themeController.getTheme();
  }

  @override
  void onClose() {
    pageController!.dispose();
    super.onClose();
  }

  void getProduct() async {
    try {
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
    } catch (e) {
      Utils.showSnackBar(text: "$e");
    }
  }

  Future<void> getOrder() async {
    // try {
    Map<String, dynamic> _dataForGet = {
      "order_id": "all",
      "user_id": sessionController.id!.value,
    };

    BaseResponseOrder result =
        await _apiRepository.getOrderById(data: _dataForGet);

    // print(data.status);
    if (result.status! && result.data != null) {
      orderMasterModel.value = result.data!;
    } else {
      if (!result.status!) Utils.showSnackBar(text: result.message!);
    }
    // } catch (e) {
    //   Utils.showSnackBar(text: "$e");
    // }
    return;
  }

  void logout() {
    sessionController.clearSession();
    Utils.offAndToNamed(name: AppRoutes.LOGINSCREEN);
    // Get.delete<AccountController>();
    Get.delete<HomeController>();
  }

  void openBottomSheet() {
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(8.0),
          height: MediaQuery.of(ctx).size.height * 0.4,
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 1,
            children: [
              ...listDataProduct
                  .map((e) => InkWell(
                        onTap: () {
                          Get.back();
                          Utils.navigateTo(
                                  name: AppRoutes.USERCREATEORDER,
                                  args: {
                                "data": [e]
                              })!
                              .then((value) => getOrder());
                        },
                        child: CategoryWidget(
                          iconData: Utils.getIcon(e!.prodId!),
                          actionText: e.prodNm!,
                          isSelected: false,
                        ),
                      ))
                  .toList()
            ],
          ),
        ),
        elevation: 2.0,
        backgroundColor: theme.backgroundColor,
        barrierColor: Colors.grey.withOpacity(0.2));
  }
}
