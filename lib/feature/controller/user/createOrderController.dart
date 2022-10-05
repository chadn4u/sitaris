import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/feature/model/city/city.dart';
import 'package:sitaris/feature/model/kecamatan/kecamatan.dart';
import 'package:sitaris/feature/model/kelurahan/kelurahan.dart';
import 'package:sitaris/feature/model/province/province.dart';
import 'package:sitaris/utils/textType.dart';
import 'package:sitaris/utils/utils.dart';

class CreateOrderController extends BaseController {
  late ThemeData theme;
  late ThemeController themeController;
  late TextEditingController namaController;
  late TextEditingController addressController;
  late PageController pageController;
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

    debugPrint(sessionController.name!.value);

    theme = themeController.getTheme();
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
        isDense: true,
        contentPadding: const EdgeInsets.all(0),
      ),
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
    );
  }
}
