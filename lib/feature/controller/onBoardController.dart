// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/core/sqlite/city/city.dart';
import 'package:sitaris/core/sqlite/city/cityDao.dart';
import 'package:sitaris/core/sqlite/config/config.dart';
import 'package:sitaris/core/sqlite/config/configDao.dart';
import 'package:sitaris/core/sqlite/kecamatan/kecamatan.dart';
import 'package:sitaris/core/sqlite/kecamatan/kecamatanDao.dart';
import 'package:sitaris/core/sqlite/kelurahan/kelurahan.dart';
import 'package:sitaris/core/sqlite/kelurahan/kelurahanDao.dart';
import 'package:sitaris/core/sqlite/province/province.dart';
import 'package:sitaris/core/sqlite/province/provinceDao.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/feature/model/city/city.dart';
import 'package:sitaris/feature/model/config/config.dart';
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
    getToken().then((value) {
      // Utils.showSnackBar(text: "test ${sessionController.name!.value}");
      if (sessionController.name != null) {
        navigateNext();
      } else {
        Utils.offAndToNamed(name: AppRoutes.LOGINSCREEN);
      }
      Get.delete<OnBoardController>();
      // getConfig().then((value) {
      //   if (value) {

      //   }
      // }).catchError((onError) {
      //   Utils.showSnackBar(text: onError);
      // });
    }).catchError((onError) {
      Utils.showSnackBar(text: onError.toString());
    });

    // Future.delayed(const Duration(seconds: 5), () {

    // });
  }

  void deleteLocalData() {
    ProvinceDAO provDao = new ProvinceDAO();
    CityDao cityDao = new CityDao();
    KecamatanDAO kecDao = new KecamatanDAO();
    KelurahanDAO kelDao = new KelurahanDAO();

    provDao.getDbInstance().then((value) => provDao.deleteAllData());
    cityDao.getDbInstance().then((value) => cityDao.deleteAllData());
    kecDao.getDbInstance().then((value) => kecDao.deleteAllData());
    kelDao.getDbInstance().then((value) => kelDao.deleteAllData());
  }

  void callAllAdress(bool forceDelete) async {
    if (forceDelete) {
      deleteLocalData();
    }
    await getProvince().then((value) => getCity()
        .then((value) => getKecamatan().then((value) => getKelurahan())));
  }

  Future<bool> getConfig() async {
    try {
      BaseResponseConfig result = await _apiRepository.postConfig(data: {
        "configs": [
          {"label": "ADDRESS_CFG"}
        ]
      });

      if (result.status! && result.data != null) {
        List<ConfigModel?> datas = result.data!;
        ConfigDAO dao = new ConfigDAO();
        dao.getDbInstance().then((value) {
          datas.forEach((element) async {
            ConfigTable configTable = ConfigTable(
                label: element?.labelConfig,
                versions: element?.version,
                valueBools: element?.valueBool,
                valueDoubles: element?.valueDouble,
                valueInts: element?.valueInt,
                valueStrings: element?.valueString);

            ConfigTable? localConfig =
                await dao.getConfigById(configTable.labelConfig);
            if (localConfig == null) {
              dao.insert(configTable);
              callAllAdress(false);
            } else {
              if (int.parse(localConfig.version!) <
                  int.parse(configTable.version!)) {
                callAllAdress(true);
              }
            }

            // dao.insert(provinceTable);
          });
        });
      }
      return true;
    } catch (e) {
      Utils.showSnackBar(text: e.toString());
      return false;
    }
  }

  Future<void> getToken() async {
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

      return;
    } catch (e) {
      Utils.showSnackBar(text: e.toString());
    }
  }

  Future<bool> getProvince() async {
    try {
      BaseResponseProvince result = await _apiRepository.getProvince();
      List<ProvinceTable> table = [];
      if (result.data != null) {
        ProvinceDAO dao = new ProvinceDAO();
        dao.getDbInstance().then((value) {
          result.data!.forEach((element) {
            table.add(ProvinceTable(
                code: element!.provinceCode, name: element.provinceName));
          });
          dao.insert(table);
        });
      }
      return true;
    } catch (e) {
      Utils.showSnackBar(text: e.toString());
      return false;
    }
  }

  Future<bool> getCity() async {
    try {
      BaseResponseCity result = await _apiRepository.getCity("PROV12");
      List<CityTable> table = [];
      if (result.data != null) {
        CityDao dao = new CityDao();
        dao.getDbInstance().then((value) {
          result.data!.forEach((element) {
            table.add(CityTable(
                cityCodes: element!.cityCode,
                codeProvince: element.provinceCode,
                name: element.city));
          });
          dao.insert(table);
        });
      }
      return true;
    } catch (e) {
      Utils.showSnackBar(text: e.toString());
      return false;
    }
  }

  Future<bool> getKecamatan() async {
    try {
      BaseResponseKecamatan result = await _apiRepository.getKecamatan("CIT12");
      List<KecamatanTable> table = [];
      if (result.data != null) {
        KecamatanDAO dao = new KecamatanDAO();
        dao.getDbInstance().then((value) {
          result.data!.forEach((element) {
            table.add(KecamatanTable(
                cityCodes: element!.cityCode,
                codeKecamatan: element.kecamatanCode,
                name: element.kecamatan));
          });
          dao.insert(table);
        });
      }
      return true;
    } catch (e) {
      Utils.showSnackBar(text: e.toString());
      return false;
    }
  }

  Future<bool> getKelurahan() async {
    try {
      BaseResponseKelurahan result = await _apiRepository.getKelurahan("KEC1");
      List<KelurahanTable> table = [];
      if (result.data != null) {
        KelurahanDAO dao = new KelurahanDAO();
        dao.getDbInstance().then((value) {
          result.data!.forEach((element) {
            table.add(KelurahanTable(
                kelurahanCodes: element!.kelurahanCode,
                codeKecamatan: element.kecamatanCode,
                name: element.kelurahan,
                zip: element.postalCode));
          });

          dao.insert(table);
        });
      }
      return true;
    } catch (e) {
      Utils.showSnackBar(text: e.toString());
      return false;
    }
  }

  void navigateNext() {
    if (sessionController.roleId != null) {
      debugPrint("jkhgf");
      switch (sessionController.roleId!.value) {
        case "1":
        case "2":
          Utils.offAndToNamed(name: AppRoutes.HOMESCREEN);
          break;
        case "3":
          Utils.offAndToNamed(name: AppRoutes.USERHOMESCREEN);
          break;
        default:
          Utils.offAndToNamed(name: AppRoutes.LOGINSCREEN);
          break;
      }
    }
    return;
  }
}
