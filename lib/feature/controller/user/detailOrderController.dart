import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/feature/model/order/order.dart';
import 'package:sitaris/feature/model/product/product.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/button.dart';
import 'package:sitaris/utils/container.dart';
import 'package:sitaris/utils/enum.dart';
import 'package:sitaris/utils/shimmer/shimmerListProductUser.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/utils.dart';

class DetailOrderController extends BaseController {
  late ThemeData theme;
  late ThemeController themeController;
  late String orderId;
  late OrderMasterModel orderMasterModel;
  RxList<ProductModel?> listProduct = RxList();
  ApiRepository _apiRepository = new ApiRepository();
  Rx<ProductState> stateProduct = ProductState.INITIAL.obs;
  RxString error = "".obs;

  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();
    theme = themeController.getTheme();
    orderId = Get.arguments['orderId'];

    _getDataProduct();
  }

  Future<void> _getDataProduct() async {
    stateProduct.value = ProductState.LOADING;
    Map<String, dynamic> _dataForGet = {
      "order_id": orderId,
    };
    try {
      BaseResponseProduct result =
          await _apiRepository.getProductByOrderId(data: _dataForGet);
      if (result.status! && result.data != null) {
        listProduct.addAll(result.data!);
        stateProduct.value = ProductState.LOADED;
      } else {
        if (result.data == null) {
          stateProduct.value = ProductState.EMPTY;
        } else {
          stateProduct.value = ProductState.ERROR;
        }
        error.value = result.message!;
      }
      return Future.value(true);
    } catch (e) {
      stateProduct.value = ProductState.ERROR;
      error.value = e.toString();
      return Future.value(false);
    }
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

  Widget _noData({double height = 200}) {
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
              child: Lottie.asset('assets/lottie/noDocuments.json',
                  height: height)),
        ],
      ),
    );
  }

  Widget _productWidget({String? date}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: listProduct.length,
        itemBuilder: (context, index) => FxContainer(
          onTap: () {
            Utils.navigateTo(name: AppRoutes.DETAILTASKUSER, args: {
              "order": orderMasterModel,
              "product": OrderDetailModel(
                  prodId: listProduct[index]!.prodId,
                  prodNm: listProduct[index]!.prodNm),
              "tasktitle": listProduct[index]!.lastTaskActive
            });
          },
          margin: FxSpacing.bottom(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: 30,
                  height: 30,
                  child: Icon(Utils.getIcon(listProduct[index]!.prodId!),
                      color: const Color(0xFF57636C)
                      // isSelected
                      //     ? theme.colorScheme.onPrimary
                      //     : theme.colorScheme.primary,
                      )),
              FxSpacing.width(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.bodySmall(
                      listProduct[index]!.prodNm!,
                      fontWeight: 700,
                    ),
                    FxText.bodySmall(
                      Utils.dateFormat(date!),
                      fontSize: 10,
                    ),
                  ],
                ),
              ),
              FxSpacing.width(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FxText.bodySmall(
                    listProduct[index]!.lastTaskActive == null
                        ? ""
                        : listProduct[index]!.lastTaskActive!,
                    fontWeight: 600,
                    fontSize: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getWidgetProduct({String? date}) {
    switch (stateProduct.value) {
      case ProductState.ERROR:
        // errorProduct!.value = "Error Test";
        return _error(
            fnc: _getDataProduct,
            height: MediaQuery.of(Get.context!).size.height * 0.2,
            errorText: error.value);
      case ProductState.EMPTY:
        return _noData();
      case ProductState.LOADED:
        return _productWidget(date: date);
      case ProductState.INITIAL:
      case ProductState.LOADING:
      default:
        return Center(child: ShimmerListProductUser());
    }
  }
}
