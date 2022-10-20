// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/model/order/order.dart';
import 'package:sitaris/feature/model/product/product.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/button.dart';
import 'package:sitaris/utils/enum.dart';
import 'package:sitaris/utils/shimmer/shimmerOrderUser.dart';
import 'package:sitaris/utils/shimmer/simmerProductUser.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
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

  Rx<OrderState> state = OrderState.INITIAL.obs;
  Rx<ProductState> stateProduct = ProductState.INITIAL.obs;
  RxString? errorOrder = "".obs;
  RxString? errorProduct = "".obs;

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
    stateProduct.value = ProductState.LOADING;
    if (listMenu.length > 0) {
      listMenu.clear();
    }
    if (listDataProduct.length > 0) {
      listDataProduct.clear();
    }
    try {
      BaseResponseProduct result = await _apiRepository.postProducts();

      // print(data.status);
      if (result.status! && result.data!.length > 0) {
        listDataProduct.value = result.data!;
        listMenu.add(listDataProduct[0]);
        listMenu.add(listDataProduct[1]);
        listMenu.add(listDataProduct[2]);
        listMenu.add(ProductModel(prodId: "0", prodNm: "More"));
        stateProduct.value = ProductState.LOADED;
      } else {
        if (!result.status!) {
          errorProduct!.value = result.message!;
          stateProduct.value = ProductState.ERROR;
        } else {
          state.value = OrderState.EMPTY;
        }
      }
    } catch (e) {
      errorProduct!.value = e.toString();
      stateProduct.value = ProductState.ERROR;
    }
  }

  Future<void> getOrder() async {
    state.value = OrderState.LOADING;
    try {
      Map<String, dynamic> _dataForGet = {
        "order_id": "all",
        "bank_id": sessionController.bankId!.value,
        // "user_id": sessionController.id!.value,
      };

      BaseResponseOrder result =
          await _apiRepository.getOrderById(data: _dataForGet);

      // print(data.status);
      if (result.status! && result.data != null) {
        orderMasterModel.value = result.data!;
        state.value = OrderState.LOADED;
      } else {
        if (!result.status!) {
          errorOrder!.value = result.message!;
          state.value = OrderState.ERROR;
        } else if (result.data == null) {
          state.value = OrderState.EMPTY;
        } else {
          errorOrder!.value = "Unknown";
          state.value = OrderState.ERROR;
        }
      }
    } catch (e) {
      debugPrint('tai $e');
      errorOrder!.value = e.toString();
      state.value = OrderState.ERROR;
    }
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

  Widget getWidgetProduct() {
    switch (stateProduct.value) {
      case ProductState.ERROR:
        // errorProduct!.value = "Error Test";
        return _error(
            fnc: getProduct,
            height: MediaQuery.of(Get.context!).size.height * 0.2,
            errorText: errorProduct!.value);
      case ProductState.EMPTY:
        return Center(
          child: FxText.bodyMedium('No Data',
              color: theme.colorScheme.primary, fontWeight: 400, muted: true),
        );
      case ProductState.LOADED:
        return _productWidget();
      case ProductState.INITIAL:
      case ProductState.LOADING:
      default:
        return Center(child: ShimmerProductUser());
    }
  }

  Widget _productWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.8,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            color: theme.scaffoldBackgroundColor),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ...listMenu
              .map((e) => Expanded(
                    child: InkWell(
                      onTap: () {
                        if (e.prodId == "0") {
                          return openBottomSheet();
                        }
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
                    ),
                  ))
              .toList()
        ]),
      ),
    );
  }

  Widget getWidgetOrder() {
    switch (state.value) {
      case OrderState.ERROR:
        // errorOrder!.value = "Error Test";
        return _error(fnc: getOrder, errorText: errorOrder!.value);
      case OrderState.EMPTY:
        return Center(
          child: _noData(),
        );
      case OrderState.LOADED:
        return Expanded(
          child: RefreshIndicator(
            onRefresh: getOrder,
            child: ListView.builder(
              itemCount: orderMasterModel.length,
              itemBuilder: (context, index) => _singleWorker(
                  name: orderMasterModel[index]!.orderNo!,
                  orderId: orderMasterModel[index]!.orderId,
                  date: orderMasterModel[index]!.orderDt,
                  totalProduct:
                      orderMasterModel[index]!.orderDetail!.length.toString(),
                  status: orderMasterModel[index]!.statusNm!),
            ),
          ),
        );
      case OrderState.INITIAL:
      case OrderState.LOADING:
      default:
        return Expanded(child: ShimmerOrderUser());
    }
  }

  Widget _noData() {
    return Container(
      margin: FxSpacing.fromLTRB(24, 12, 12, 0),
      padding: FxSpacing.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Lottie.asset('assets/lottie/empty.json', height: 200)),
          Container(
            margin: FxSpacing.top(8),
            width: MediaQuery.of(Get.context!).size.width * 0.6,
            child: FxText.bodyMedium('Order kamu masih kosong.',
                textAlign: TextAlign.center,
                color: theme.colorScheme.primary,
                fontWeight: 400,
                muted: true),
          ),
        ],
      ),
    );
  }

  Widget _error(
      {required VoidCallback fnc, double height = 200, required errorText}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
      padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Lottie.asset('assets/lottie/error.json', height: height)),
          Container(
            margin: FxSpacing.top(8),
            width: MediaQuery.of(Get.context!).size.width * 0.6,
            child: FxText.bodyMedium(errorText,
                textAlign: TextAlign.center,
                color: theme.colorScheme.primary,
                fontWeight: 400,
                muted: true),
          ),
          FxSpacing.height(10),
          FxButton.medium(
            onPressed: fnc,
            backgroundColor: theme.colorScheme.primary,
            child: FxText.bodyMedium("Retry",
                color: Colors.white, fontWeight: 400, muted: true),
            buttonType: FxButtonType.elevated,
          )
        ],
      ),
    );
  }

  Widget _singleWorker({
    required String name,
    required String totalProduct,
    String? orderId,
    String? date,
    required String status,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: MediaQuery.of(Get.context!).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: InkWell(
          onTap: () {
            // debugPrint(date);
            Utils.navigateTo(name: AppRoutes.DETAILORDERSCREEN, args: {
              "orderDt": date,
              "orderNo": name,
              "orderId": orderId,
              "label": orderId
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 4, 8),
                child: Container(
                  width: 4,
                  height: 90,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: theme.primaryColor),

                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.all(Radius.circular(8)),
                  //   child: Image(
                  //     image: AssetImage(image),
                  //     width: 72,
                  //     height: 72,
                  //   ),
                  // ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 16, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FxText.titleLarge(
                      name,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 600,
                    ),
                    FxText.bodyMedium(
                      "Total Products : ($totalProduct)",
                      color: theme.colorScheme.onBackground,
                      fontWeight: 600,
                    ),
                    FxText.bodyMedium(
                      "Status: $status",
                      color: theme.colorScheme.onBackground,
                      fontWeight: 600,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
