import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/feature/model/baseResponse/baseResponse.dart';
import 'package:sitaris/feature/model/city/city.dart';
import 'package:sitaris/feature/model/kecamatan/kecamatan.dart';
import 'package:sitaris/feature/model/kelurahan/kelurahan.dart';
import 'package:sitaris/feature/model/orderPreset/orderPreset.dart';
import 'package:sitaris/feature/model/product/product.dart';
import 'package:sitaris/feature/model/province/province.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/textType.dart';
import 'package:sitaris/utils/utils.dart';

enum ProcessEnum { loading, finish }

class CreateOrderController extends BaseController {
  late ThemeData theme;
  late ThemeController themeController;
  late TextEditingController namaController;
  late TextEditingController addressController;
  late PageController pageController;
  late ProductModel dataProduct;
  late String orderNo;

  Rx<ProcessEnum> process = ProcessEnum.finish.obs;

  final f = new DateFormat('yyyyMMdd');
  RxList<FileTypeModel?> fileType = RxList();
  DateTime? currentBackPressTime;

  RxString valueProv = "".obs;
  RxList<ProvinceModel?> selectedProvince = RxList();

  RxString valueCity = "".obs;
  RxList<CityModel?> selectedCity = RxList();

  RxString valueKec = "".obs;
  RxList<KecamatanModel?> selectedKec = RxList();

  RxString valueKel = "".obs;
  RxList<KelurahanModel?> selectedKel = RxList();

  ApiRepository _apiRepository = ApiRepository();

  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();
    namaController = TextEditingController();
    namaController.text = sessionController.name!.value.toUpperCase();
    addressController = TextEditingController();
    pageController = PageController(initialPage: 0);
    getProvince();
    getOrderId();

    theme = themeController.getTheme();
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<CreateOrderController>();
  }

  void validate() {
    if (valueProv.isEmpty) {
      Utils.showSnackBar(text: "Provinsi tidak boleh kosong");
    } else if (valueCity.isEmpty) {
      Utils.showSnackBar(text: "Kota tidak boleh kosong");
    } else if (valueKec.isEmpty) {
      Utils.showSnackBar(text: "Kecamatan tidak boleh kosong");
    } else if (valueKel.isEmpty) {
      Utils.showSnackBar(text: "Kelurahan tidak boleh kosong");
    } else if (addressController.text.isEmpty) {
      Utils.showSnackBar(text: "Alamat tidak boleh kosong");
    } else {
      pageController.jumpToPage(1);
    }
  }

  Future<bool> onWillPop() {
    if (pageController.page != 0) {
      pageController.jumpToPage(0);
      return Future.value(false);
    }
    return Future.value(true);
    // else {
    //   DateTime now = DateTime.now();
    //   if (currentBackPressTime == null) {
    //     currentBackPressTime = now;

    //     Utils.showSnackBar(text: "Tekan kembali setelah 3 detik");

    //     return Future.value(false);
    //   } else {
    //     if (now.difference(currentBackPressTime!) > Duration(seconds: 3)) {
    //       currentBackPressTime = now;

    //       Utils.showSnackBar(text: "Tekan kembali setelah 3 detik");

    //       return Future.value(false);
    //     }
    //   }
    //   return Future.value(true);
    // }
  }

  Future<bool> getProvince() async {
    try {
      BaseResponseProvince result = await _apiRepository.getProvince();
      if (result.data != null) {
        selectedProvince.addAll(result.data!);
        valueProv = selectedProvince[0]!.provinceCode!.obs;
      }
      return true;
    } catch (e) {
      Utils.showSnackBar(text: e.toString());
      return false;
    }
  }

  Future<bool> getCity(String provCode) async {
    selectedCity.clear();
    try {
      BaseResponseCity result = await _apiRepository.getCity(provCode);
      if (result.data != null) {
        selectedCity.addAll(result.data!);
        valueCity = selectedCity[0]!.cityCode!.obs;
      }
      return true;
    } catch (e) {
      Utils.showSnackBar(text: e.toString());
      return false;
    }
  }

  Future<bool> getKecamatan(String cityCode) async {
    selectedKec.clear();
    try {
      BaseResponseKecamatan result =
          await _apiRepository.getKecamatan(cityCode);
      if (result.data != null) {
        selectedKec.addAll(result.data!);
        valueKec = selectedKec[0]!.kecamatanCode!.obs;
      }

      return true;
    } catch (e) {
      Utils.showSnackBar(text: e.toString());
      return false;
    }
  }

  Future<bool> getKelurahan(String kecCode) async {
    selectedKel.clear();
    try {
      BaseResponseKelurahan result = await _apiRepository.getKelurahan(kecCode);
      if (result.data != null) {
        selectedKel.addAll(result.data!);
        valueKel = selectedKel[0]!.kelurahanCode!.obs;
      }

      return true;
    } catch (e) {
      Utils.showSnackBar(text: e.toString());
      return false;
    }
  }

  Future<void> getOrderId() async {
    try {
      BaseResponseOrderPreset result = await _apiRepository.postOrderId();
      if (result.status!) {
        orderNo = result.data!.orderNo!;
      } else {
        throw result.message!;
      }

      return;
    } catch (e) {
      Utils.showSnackBar(text: e.toString());
    }
  }

  void resetOther(String type) {
    switch (type) {
      case "Province":
        valueKec.value = "";
        selectedKec.clear();

        valueKel.value = "";
        selectedKel.clear();

        break;
      case "City":
        valueKel.value = "";
        selectedKel.clear();

        break;
      default:
        break;
    }
  }

  void submitOrder() async {
    changeStateBtnOrder();
    try {
      fileType.forEach((element) {
        if (element!.data!.length == 0) {
          throw "Dokumen ${element.label} masih kosong";
        }
      });
    } catch (es) {
      changeStateBtnOrder();
      return Utils.showSnackBar(text: es.toString());
    }
    // List<FileTypeModel?> dataForSent = fileType;
    // dataForSent.forEach((element) {
    //   element!.data["value"] = base64Encode(element!.data["value"]);
    // });
    Map<String, dynamic> _dataForPost = {
      "order_no": orderNo, //ambil dari hit API
      "order_dt": f.format(DateTime.now()).toString(),
      "bank_id": sessionController.bankId!.value,
      "cust_nm": sessionController.name!.value,
      "cust_addr": addressController.text,
      "cust_kel": valueKel.value,
      "cust_kodepos": selectedKel
          .firstWhere((element) => (element!.kelurahanCode == valueKel.value))!
          .postalCode,
      "create_by": sessionController.id!.value,
      "products": [
        {
          "prod_id": dataProduct.prodId,
          "prod_nm": dataProduct.prodNm,
          "files": jsonEncode(fileType)
        }
      ]
    };
    try {
      BaseResponse result = await _apiRepository.postOrder(data: _dataForPost);
      if (result.status!) {
        Utils.showSnackBar(text: result.message!);
        changeStateBtnOrder();
        Future.delayed(Duration(seconds: 3), () {
          Get.back(closeOverlays: true);
        });
      } else {
        throw result.message!;
      }

      return;
    } catch (e) {
      changeStateBtnOrder();
      Utils.showSnackBar(text: e.toString());
    }
    // debugPrint(_dataForPost.toString());
    // _apiRepo
  }

  Widget textBox(
      {String? hint,
      IconData? icon,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      // initialValue: sessionController.name!.value,
      style: FxTextStyle.titleSmall(
          letterSpacing: 0,
          color: theme.colorScheme.onBackground,
          fontWeight: 500),
      decoration: InputDecoration(
        floatingLabelAlignment: FloatingLabelAlignment.start,
        label: FxText.bodySmall("Nama",
            fontSize: 15, fontWeight: 700, muted: true, color: Colors.black),
        hintText: hint,
        hintStyle: FxTextStyle.titleSmall(
            letterSpacing: 0,
            color: theme.colorScheme.onBackground,
            fontWeight: 500),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          icon,
          size: 22,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  void changeStateBtnOrder() {
    if (process.value == ProcessEnum.finish) {
      process.value = ProcessEnum.loading;
    } else {
      process.value = ProcessEnum.finish;
    }
  }

  Widget contactInfoWidget(
      {required String type,
      required String label,
      String? valueDropDown,
      Function(String?)? onChangeDropDown,
      List<DropdownMenuItem<String>>? item}) {
    switch (type) {
      case "TextBox":
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: textBox(
              controller: namaController, hint: label, icon: Icons.people),
        );
      case "DropDown":
        return Container(
            padding: const EdgeInsets.all(8.0),
            child: InputDecorator(
              // isEmpty: getXHome.choiceSelected.value == '',
              decoration: InputDecoration(
                label: FxText.bodySmall(label,
                    fontSize: 15,
                    fontWeight: 700,
                    muted: true,
                    color: Colors.black),
                hintText: 'Pilih $label',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 14.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 1.0,
                  ),
                ),
              ),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: valueDropDown,
                      isDense: true,
                      onChanged: onChangeDropDown,
                      items: item)),
            ));
      case "TextArea":
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: addressController,
            decoration: InputDecoration(
                label: FxText.bodySmall(label,
                    fontSize: 15,
                    fontWeight: 700,
                    muted: true,
                    color: Colors.black),
                hintText: "Input $label anda",
                isDense: true,
                filled: true,
                fillColor: theme.colorScheme.background,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 14.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 1.0,
                  ),
                )),
            textCapitalization: TextCapitalization.sentences,
            minLines: 5,
            maxLines: 10,
          ),
        );
      default:
        return Container();
    }
  }

  void openBottomSheet({required String label}) {
    final ImagePicker _picker = ImagePicker();

    Get.bottomSheet(
        Container(
            padding: const EdgeInsets.all(8.0),
            height: MediaQuery.of(Get.context!).size.height * 0.15,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    // Pick an image
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    Uint8List byteImage = await image!.readAsBytes();
                    fileType
                        .firstWhere((element) => element!.label == label)!
                        .data!
                        .add({
                      "id": image.hashCode,
                      "value": base64Encode(byteImage)
                    });
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FxText.bodyLarge("Browse Image",
                            letterSpacing: 0.3,
                            fontWeight: 600,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.camera);
                    Uint8List byteImage = await image!.readAsBytes();
                    // debugPrint(byteImage.toString());
                    fileType
                        .firstWhere((element) => element!.label == label)!
                        .data!
                        .add({
                      "id": image.name,
                      "value": base64Encode(byteImage)
                    });
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FxText.bodyLarge("Camera",
                            letterSpacing: 0.3,
                            fontWeight: 600,
                            color: Colors.black),
                      )
                    ],
                  ),
                )
              ],
            )),
        elevation: 2.0,
        backgroundColor: theme.backgroundColor,
        barrierColor: Colors.grey.withOpacity(0.2));
  }
}
