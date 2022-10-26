// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/feature/model/order/order.dart';
import 'package:sitaris/feature/model/product/product.dart';
import 'package:sitaris/feature/model/task/taskByDept.dart';
import 'package:sitaris/feature/presentation/home.dart';
import 'package:sitaris/utils/container.dart';
import 'package:sitaris/utils/enum.dart';
import 'package:sitaris/utils/shimmer/shimmerOrderAdmin.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';

import '../../route/routes.dart';
import '../../utils/utils.dart';

class HomeController extends BaseController {
  late ThemeData theme;
  late ThemeController themeController;
  late List<Map<String, dynamic>> dummy;
  RxList<Map<String, dynamic>> dummyList = <Map<String, dynamic>>[].obs;
  RxList<ProductModel?> listDataProduct = <ProductModel?>[].obs;

  ScrollController scrollController = ScrollController();
  ApiRepository _apiRepository = ApiRepository();
  late TabController tabController;
  RxInt selectedIndex = 0.obs;

  Rx<LoadingProductState> state = LoadingProductState.INITIAL.obs;
  Rx<LoadingOrderState> stateOrder = LoadingOrderState.INITIAL.obs;
  String? errorTextOrder = "";

  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();

    // debugPrint('Value session ${sessionController.compCellNo!.value}');

    theme = themeController.getTheme();

    dummy = [
      {
        "title": "Terima Berkas",
        "color": Colors.blue.shade100,
        "icon": Icons.book
      },
      {"title": "Covernote", "color": Colors.red.shade100, "icon": Icons.note},
      {
        "title": "Pengeluaran",
        "color": Colors.green.shade100,
        "icon": Icons.exit_to_app
      },
    ];
    if (sessionController.roleId!.value == '1')
      getOrder();
    else
      getTask();
  }

  Future<void> getTask() async {
    stateOrder.value = LoadingOrderState.LOADING;
    try {
      Map<String, dynamic> _dataForGet = {
        "dept_id": sessionController.deptId!.value,
      };
      dummyList.clear();

      BaseResponseTaskByDept result =
          await _apiRepository.getTaskByDept(data: _dataForGet);

      // print(data.status);
      if (result.status! && result.data != null) {
        //20221007
        if (result.data!.length > 0) {
          result.data!.forEach((element) {
            // debugPrint('a');
            //list Task
            element!.orders!.forEach((elements) {
              // debugPrint('b');
              //list Ordernya
              elements!.orderDetail!.forEach((elementsss) {
                // debugPrint('c');
                //List Productnya
                dummyList.add({
                  "initial": getIcon(elements.statusNm!),
                  "status": elements.statusNm!,
                  "nama": elements.orderCustNm!.toUpperCase(),
                  "dateForFormat": elements.orderDt,
                  "order": elements,
                  "product": elementsss,
                  "taskNm": element.taskHead,
                  "title": element.taskHead!.toUpperCase(),
                  "subtitle":
                      "No. Order: #${elements.orderNo} | ${elementsss!.prodNm!}",
                });
              });
            });
          });
          stateOrder.value = LoadingOrderState.LOADED;
        } else {
          stateOrder.value = LoadingOrderState.EMPTY;
        }
      } else {
        errorTextOrder = result.message!;
        stateOrder.value = LoadingOrderState.ERROR;
        // if (!result.status!) Utils.showSnackBar(text: result.message!);
      }
    } catch (e) {
      errorTextOrder = e.toString();
      stateOrder.value = LoadingOrderState.ERROR;
      // Utils.showSnackBar(text: "$e");
    }
    return;
  }

  Future<void> getOrder() async {
    stateOrder.value = LoadingOrderState.LOADING;
    try {
      Map<String, dynamic> _dataForGet = {
        "order_id": "all",
      };
      dummyList.clear();

      BaseResponseOrder result =
          await _apiRepository.getOrderById(data: _dataForGet);

      // print(data.status);
      if (result.status! && result.data != null) {
        //20221007
        if (result.data!.length > 0) {
          result.data!.forEach((element) {
            dummyList.add({
              "initial": getIcon(element!.statusNm!),
              "status": element.statusNm!,
              "nama": element.orderCustNm!.toUpperCase(),
              "dateForFormat": element.orderDt,
              "orderNo": element.orderNo,
              "orderId": element.orderId,
              "order": element,
              "title": element.bankNm!.toUpperCase(),
              "subtitle": "No. Order: #${element.orderNo}",
            });
          });
          stateOrder.value = LoadingOrderState.LOADED;
        } else {
          stateOrder.value = LoadingOrderState.EMPTY;
        }
      } else {
        errorTextOrder = result.message!;
        stateOrder.value = LoadingOrderState.ERROR;
        // if (!result.status!) Utils.showSnackBar(text: result.message!);
      }
    } catch (e) {
      errorTextOrder = e.toString();
      stateOrder.value = LoadingOrderState.ERROR;
      // Utils.showSnackBar(text: "$e");
    }
    return;
  }

  String getIcon(String status) {
    switch (status) {
      case "NEW":
        return "assets/icon/new.png";
      case "IN PROGRESS":
        return "assets/icon/on-process.png";
      case "COMPLETE":
        return "assets/icon/completed.png";
      case "CANCELED":
        return "assets/icon/cancel.png";
      default:
        return "assets/icon/new.png";
    }
  }

  void showBottomSheet() async {
    state.value = LoadingProductState.LOADING;
    try {
      listDataProduct.clear();
      BaseResponseProduct result = await _apiRepository.postProducts();

      // print(data.status);
      if (result.status!) {
        state.value = LoadingProductState.LOADED;
        listDataProduct.value = result.data!;
        Get.bottomSheet(
            Container(
                padding: const EdgeInsets.all(8.0),
                height: MediaQuery.of(Get.context!).size.height,
                child: Column(
                  children: [
                    FxText.titleSmall(
                      "Pilih Produk",
                      fontWeight: 800,
                    ),
                    FxSpacing.height(8),
                    selectProduct(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 24),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      FxSpacing.xy(16, 0))),
                              onPressed: () {
                                int selected = 0;
                                listDataProduct.forEach((element) {
                                  if (element!.selected) {
                                    selected++;
                                  }
                                });
                                if (selected > 0) {
                                  Get.back();
                                  Utils.navigateTo(
                                          name: AppRoutes.USERCREATEORDER,
                                          args: {"data": listDataProduct})!
                                      .then((value) {
                                    if (sessionController.roleId == "1") {
                                      getOrder();
                                    } else {
                                      getTask();
                                    }
                                  });
                                } else {
                                  Utils.showSnackBar(
                                      text: "Product belum di pilih");
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Icon(
                                    FeatherIcons.logOut,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 16),
                                    child: const FxText.bodySmall("Next",
                                        letterSpacing: 0.3,
                                        fontWeight: 600,
                                        color: Colors.white),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    )
                  ],
                )),
            backgroundColor: theme.backgroundColor,
            barrierColor: Colors.grey.withOpacity(0.2));
      } else {
        state.value = LoadingProductState.ERROR;
        Utils.showSnackBar(text: result.message!);
      }
    } catch (e) {
      state.value = LoadingProductState.ERROR;
      Utils.showSnackBar(text: "$e");
    }
  }

  Widget selectProduct() {
    return StatefulBuilder(builder: (context, setState) {
      return Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) => FxContainer(
            onTap: () {
              setState(() {
                listDataProduct
                    .firstWhere((element) =>
                        element!.prodId == listDataProduct[index]!.prodId)!
                    .selected = !listDataProduct[index]!.selected;
              });
            },
            margin: FxSpacing.bottom(16),
            padding: FxSpacing.all(16),
            bordered: true,
            border: Border.all(color: Colors.grey),
            color: theme
                .scaffoldBackgroundColor, //isSelected ? customTheme.card : theme.scaffoldBackgroundColor,
            borderRadiusAll: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Material(
                    color: const Color(0xFFF1F4F8),
                    // isSelected
                    //     ? theme.colorScheme.primary
                    //     : theme.colorScheme.primary.withAlpha(20),
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(
                            Utils.getIcon(listDataProduct[index]!.prodId!),
                            color: const Color(0xFF57636C)
                            // isSelected
                            //     ? theme.colorScheme.onPrimary
                            //     : theme.colorScheme.primary,
                            )),
                  ),
                ),
                FxSpacing.width(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.bodyMedium(listDataProduct[index]!.prodNm!,
                          fontWeight: 600),
                    ],
                  ),
                ),
                // isSelected ? Space.width(16) : Space.width(20),
                listDataProduct[index]!.selected
                    ? Container(
                        padding: FxSpacing.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xff10bb6b).withAlpha(40)),
                        child: Icon(
                          FeatherIcons.check,
                          color: const Color(0xff10bb6b),
                          size: 14,
                        ),
                      )
                    : Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xff10bb6b))),
                      ),
              ],
            ),
          ),
          itemCount: listDataProduct.length,
        ),
      );
    });
  }

  Widget getListData() {
    switch (stateOrder.value) {
      case LoadingOrderState.ERROR:
        return FxText.bodySmall(errorTextOrder!,
            letterSpacing: 0.3, fontWeight: 600, color: Colors.black);
      case LoadingOrderState.LOADED:
        return ListData(data: dummyList);
      case LoadingOrderState.INITIAL:
      case LoadingOrderState.LOADING:
      default:
        return ShimmerOrderAdmin();
    }
  }
}
