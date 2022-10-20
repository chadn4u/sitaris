import 'dart:convert';
import 'dart:isolate';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
import 'package:sitaris/feature/model/konsumen/konsumen.dart';
import 'package:sitaris/feature/model/product/product.dart';
import 'package:sitaris/feature/model/province/province.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/textType.dart';
import 'package:sitaris/utils/utils.dart';
import 'package:image/image.dart' as img;

enum ProcessEnum { loading, finish }

class CreateOrderController extends BaseController {
  late ThemeData theme;
  late ThemeController themeController;
  late TextEditingController namaController;
  late TextEditingController sertifikat;
  late TextEditingController addressController;
  late PageController pageController;
  RxList<ProductModel?> dataProduct = RxList();

  Rx<ProcessEnum> process = ProcessEnum.finish.obs;
  RxInt activePage = 0.obs;

  final f = new DateFormat('yyyyMMdd');
  RxList<FileTypeModel?> fileType = RxList();
  RxList<FileTypeModel?> fileTypeBase = RxList();
  DateTime? currentBackPressTime;

  RxString valueKonsumen = "".obs;
  RxList<KonsumenModel?> selectedKonsumen = RxList();

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
    sertifikat = TextEditingController();

    addressController = TextEditingController();
    pageController = PageController(initialPage: 0);
    getProvince();
    // getOrderId();

    if (sessionController.roleId == "1") {
      getKonsumen();
    }

    theme = themeController.getTheme();
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<CreateOrderController>();
  }

  void validate() {
    debugPrint(valueProv.value);
    debugPrint(valueCity.value);
    debugPrint(valueKec.value);
    debugPrint(valueKel.value);
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
    } else if (namaController.text == "") {
      Utils.showSnackBar(text: "Nama debitur tidak boleh kosong");
    } else if (sertifikat.text == "") {
      Utils.showSnackBar(text: "Sertifikat tidak boleh kosong");
    } else {
      if (sessionController.roleId == "1") {
        if (valueKonsumen.isEmpty) {
          Utils.showSnackBar(text: "Kategori konsumen tidak boleh kosong");
        } else {
          pageController.jumpToPage(1);
        }
      } else {
        pageController.jumpToPage(1);
      }
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

  Future<bool> getKonsumen() async {
    if (selectedKonsumen.length > 0) selectedKonsumen.clear();
    // try {
    BaseResponseKonsumen result = await _apiRepository.getKonsumen();
    if (result.data != null) {
      selectedKonsumen.addAll(result.data!);
      valueKonsumen = selectedKonsumen[0]!.bankId!.obs;
    }
    return true;
    // }
    // catch (e) {
    //   Utils.showSnackBar(text: e.toString());
    //   return false;
    // }
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

  // Future<void> getOrderId() async {
  //   try {
  //     BaseResponseOrderPreset result = await _apiRepository.postOrderId();
  //     if (result.status!) {
  //       orderNo = result.data!.orderNo!;
  //     } else {
  //       throw result.message!;
  //     }

  //     return;
  //   } catch (e) {
  //     Utils.showSnackBar(text: e.toString());
  //   }
  // }

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
    List<Map<String, dynamic>> dataProductsForSent = [];
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

    dataProduct.forEach((element) {
      List<FileTypeModel> fileTypes = [];

      element!.files?.forEach((element) {
        fileTypes.add(fileType
            .firstWhere((elemento) => elemento!.label == element!.label)!);
        ;
      });

      dataProductsForSent.add({
        "prod_id": element.prodId,
        "prod_nm": element.prodNm,
        "files": jsonEncode(fileTypes)
      });
    });

    Map<String, dynamic> _dataForPost = {
      // "order_no": orderNo, //ambil dari hit API
      "order_dt": f.format(DateTime.now()).toString(),
      "sertifikat_no": sertifikat.text,
      "bank_id": (sessionController.roleId == "1")
          ? valueKonsumen.value
          : sessionController.bankId!.value,
      "cust_nm": namaController.text,
      "cust_addr": addressController.text,
      "cust_kel": valueKel.value,
      "cust_kodepos": selectedKel
          .firstWhere((element) => (element!.kelurahanCode == valueKel.value))!
          .postalCode,
      "create_by": sessionController.id!.value,
      "products": dataProductsForSent
    };
    try {
      BaseResponse result = await _apiRepository.postOrder(data: _dataForPost);
      if (result.status!) {
        Utils.showSnackBar(text: result.message!);
        changeStateBtnOrder();
        pageController.jumpToPage(2);
        fileType.clear();
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
      readOnly: false,
      // initialValue: sessionController.name!.value,
      style: FxTextStyle.titleSmall(
          letterSpacing: 0,
          color: theme.colorScheme.onBackground,
          fontWeight: 500),
      decoration: InputDecoration(
        floatingLabelAlignment: FloatingLabelAlignment.start,
        label: FxText.bodySmall(hint!,
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
      dynamic selectedDropDown,
      TextEditingController? controllerTextbox,
      String? valueDropDown,
      Function(dynamic)? onChangeDropDown,
      String? dropDownType,
      List<dynamic>? item}) {
    switch (type) {
      case "TextBox":
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: textBox(
              controller: controllerTextbox!, hint: label, icon: Icons.people),
        );
      case "DropDown":
        return Container(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSearch<dynamic>(
              selectedItem: selectedDropDown,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
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
              ),
              itemAsString: (item) {
                if (dropDownType == "Konsumen") {
                  item as KonsumenModel;
                  return item.bankNm!;
                } else if (dropDownType == "Province") {
                  item as ProvinceModel;
                  return item.provinceName!;
                } else if (dropDownType == "City") {
                  item as CityModel;
                  return item.city!;
                } else if (dropDownType == "Kecamatan") {
                  item as KecamatanModel;
                  return item.kecamatan!;
                } else {
                  item as KelurahanModel;
                  return item.kelurahan!;
                }
              },
              popupProps: PopupProps.menu(
                showSearchBox: true,
              ),
              items: item!,
              onChanged: onChangeDropDown,
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
                    Get.back();

                    // Pick an image
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (!image!.path.isImageFileName) {
                      return Utils.showSnackBar(
                          text:
                              "Invalid format file, (Only .jpg,.png are allowed)");
                    }
                    Uint8List byteImage = await image.readAsBytes();
                    byteImage = await compressImage(byteImage);
                    fileType
                        .firstWhere((element) => element!.label == label)!
                        .data!
                        .add({
                      "id": image.hashCode,
                      "value": base64Encode(byteImage)
                    });
                    // Get.back();
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
                    Get.back();

                    final XFile? image = await _picker.pickImage(
                        source: ImageSource.camera, imageQuality: 80);
                    Uint8List byteImage = await image!.readAsBytes();
                    byteImage = await compressImage(byteImage);
                    fileType
                        .firstWhere((element) => element!.label == label)!
                        .data!
                        .add({
                      "id": image.name,
                      "value": base64Encode(byteImage)
                    });
                    // Get.back();
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

  Future<Uint8List> compressImage(Uint8List list,
      {int? height, int? width}) async {
    Uint8List listProcess = list;
    int length = listProcess.lengthInBytes;
    int maxLength = 500000;
    int retry = 1;
    if (length > maxLength) {
      Get.dialog(
          Center(
            child: Container(
              width: Utils.dynamicWidth(70),
              height: Utils.dynamicHeight(15),
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    FxSpacing.height(10),
                    FxText.bodyMedium('Compressing image')
                  ]),
            ),
          ),
          barrierDismissible: false,
          barrierColor: Colors.grey.withOpacity(0.3));

      await Future.delayed(Duration(seconds: 1), () async {
        while (length > maxLength) {
          ReceivePort port = ReceivePort();
          img.Image image_temp = img.decodeImage(listProcess)!;
          int height;
          int width;
          debugPrint("$length $maxLength ${retry.toString()}");
          // if (image_temp.height > 1024) {
          height = (image_temp.height * _getPercentCompress(retry)).toInt();
          // } else {
          //   height = image_temp.height;
          // }

          // if (image_temp.width > 1024) {
          width = (image_temp.width * _getPercentCompress(retry)).toInt();
          // } else {
          //   width = image_temp.width;
          // }

          // img.Image resized_img =
          //     img.copyResize(image_temp, width: width, height: height);
          // listProcess = Uint8List.fromList(img.encodePng(resized_img));
          final isolate = await Isolate.spawn<List<dynamic>>(
              _resizedImg, [port.sendPort, image_temp, height, width]);
          listProcess = await port.first;
          isolate.kill(priority: Isolate.immediate);
          // Uint8List compressedImage = await compressImage(listProcess,
          //     height: image_temp.height, width: image_temp.width);

          // listProcess = compressedImage;
          length = listProcess.lengthInBytes;
          retry++;
        }
      });

      // debugPrint(byteImage.lengthInBytes.toString());
    }
    var result = await FlutterImageCompress.compressWithList(listProcess,
        quality: 96, rotate: 0, format: CompressFormat.png);
    debugPrint(list.length.toString());
    debugPrint(result.length.toString());
    if (Get.isDialogOpen!) Get.back();
    return result;
  }

  double _getPercentCompress(int retry) {
    int maxRetryCompress = 3;
    if (retry <= maxRetryCompress) {
      switch (retry) {
        case 1:
          return 0.4;
        case 2:
          return 0.6;
        case 3:
        default:
          return 0.8;
      }
    } else {
      return 0.8;
    }
  }
}

void _resizedImg(List<dynamic> values) {
  SendPort sendPort = values[0];
  img.Image image_temp = values[1];
  int? width = values[2];
  int? height = values[3];
  img.Image resized_img =
      img.copyResize(image_temp, width: width!, height: height!);
  sendPort.send(Uint8List.fromList(img.encodePng(resized_img)));
  // return ;
}
