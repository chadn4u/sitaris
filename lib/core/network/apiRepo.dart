import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/core/network/rest_client.dart';
import 'package:sitaris/feature/model/baseResponse/baseResponse.dart';
import 'package:sitaris/feature/model/city/city.dart';
import 'package:sitaris/feature/model/config/config.dart';
import 'package:sitaris/feature/model/kecamatan/kecamatan.dart';
import 'package:sitaris/feature/model/kelurahan/kelurahan.dart';
import 'package:sitaris/feature/model/konsumen/konsumen.dart';
import 'package:sitaris/feature/model/login/login.dart';
import 'package:sitaris/feature/model/order/order.dart';
import 'package:sitaris/feature/model/orderPreset/orderPreset.dart';
import 'package:sitaris/feature/model/product/product.dart';
import 'package:sitaris/feature/model/province/province.dart';
import 'package:sitaris/feature/model/task/taskByDept.dart';
import 'package:sitaris/feature/model/token/token.dart';

class ApiRepository {
  late RestClient restClient;
  ApiRepository() {
    restClient = Get.find();
  }
  Future<TokenModel> postToken(
      {Map<String, dynamic>? data, bool refresh = false}) async {
    final result = await restClient.request(
        "${BASE_URL_TOKEN}authorize/client_credentials", Method.POST, data);

    if (!refresh) restClient.close();
    debugPrint('token ${restClient.connectionClose}');

    return TokenModel.fromJson(result);
  }

  Future<BaseResponseLogin> postLogin({Map<String, dynamic>? data}) async {
    final result =
        await restClient.request("${BASE_URL}loginusr", Method.POST, data,
            opt: Options(
              headers: {
                'requirestoken': true,
              },
            ));
    restClient.close();

    return BaseResponseLogin.fromJson(result);
  }

  Future<BaseResponseProduct> postProducts({Map<String, dynamic>? data}) async {
    final result =
        await restClient.request("${BASE_URL}listproduct", Method.GET, data,
            opt: Options(
              headers: {
                'requirestoken': true,
              },
            ));
    restClient.close();

    return BaseResponseProduct.fromJson(result);
  }

  Future<BaseResponseKelurahan> getKelurahan(String kecCode) async {
    final result = await restClient.request(
        "${BASE_URL}listkelurahan/${kecCode}", Method.GET, {},
        opt: Options(
          headers: {
            'requirestoken': true,
          },
        ));
    restClient.close();

    return BaseResponseKelurahan.fromJson(result);
  }

  Future<BaseResponseKecamatan> getKecamatan(String cityCode) async {
    final result = await restClient.request(
        "${BASE_URL}listkecamatan/${cityCode}", Method.GET, {},
        opt: Options(
          headers: {
            'requirestoken': true,
          },
        ));
    restClient.close();

    return BaseResponseKecamatan.fromJson(result);
  }

  Future<BaseResponseCity> getCity(String provCode) async {
    final result = await restClient.request(
        "${BASE_URL}listcity/${provCode}", Method.GET, {},
        opt: Options(
          headers: {
            'requirestoken': true,
          },
        ));
    restClient.close();

    return BaseResponseCity.fromJson(result);
  }

  Future<BaseResponseProvince> getProvince({Map<String, dynamic>? data}) async {
    final result = await restClient.request(
        "${BASE_URL}listprovince/all", Method.GET, data,
        opt: Options(
          headers: {
            'requirestoken': true,
          },
        ));
    restClient.close();

    return BaseResponseProvince.fromJson(result);
  }

  Future<BaseResponseConfig> postConfig({Map<String, dynamic>? data}) async {
    final result =
        await restClient.request("${BASE_URL}config", Method.POST, data,
            opt: Options(
              headers: {
                'requirestoken': true,
              },
            ));
    restClient.close();

    return BaseResponseConfig.fromJson(result);
  }

  Future<BaseResponse> postOrder({Map<String, dynamic>? data}) async {
    final result =
        await restClient.request("${BASE_URL}addorder", Method.POST, data,
            opt: Options(
              headers: {
                'requirestoken': true,
              },
            ));
    restClient.close();

    return BaseResponse.fromJson(result);
  }

  Future<BaseResponseOrderPreset> postOrderId() async {
    final result =
        await restClient.request("${BASE_URL}presetord", Method.GET, {},
            opt: Options(
              headers: {
                'requirestoken': true,
              },
            ));
    restClient.close();

    return BaseResponseOrderPreset.fromJson(result);
  }

  Future<BaseResponseOrder> getOrderById({Map<String, dynamic>? data}) async {
    final result =
        await restClient.request("${BASE_URL}vieworder/list", Method.GET, data,
            opt: Options(
              headers: {
                'requirestoken': true,
              },
            ));
    restClient.close();

    return BaseResponseOrder.fromJson(result);
  }

  Future<BaseResponseKonsumen> getKonsumen({Map<String, dynamic>? data}) async {
    final result =
        await restClient.request("${BASE_URL}listbank", Method.GET, {},
            opt: Options(
              headers: {
                'requirestoken': true,
              },
            ));
    restClient.close();

    return BaseResponseKonsumen.fromJson(result);
  }

  Future<BaseResponse> testInterceptor({Map<String, dynamic>? data}) async {
    final result =
        await restClient.request("${BASE_URL}testing401", Method.GET, {},
            opt: Options(
              headers: {
                'requirestoken': true,
              },
            ));
    restClient.close();
    debugPrint('test ${restClient.connectionClose}');

    return BaseResponse.fromJson(result);
  }

  Future<BaseResponseProduct> getProductByOrderId(
      {Map<String, dynamic>? data}) async {
    final result = await restClient.request(
        "${BASE_URL}productbyord/list", Method.GET, data,
        opt: Options(
          headers: {
            'requirestoken': true,
          },
        ));
    restClient.close();

    return BaseResponseProduct.fromJson(result);
  }

  Future<BaseResponseTaskByDept> getTaskByDept(
      {Map<String, dynamic>? data}) async {
    final result =
        await restClient.request("${BASE_URL}taskbydept/list", Method.GET, data,
            opt: Options(
              headers: {
                'requirestoken': true,
              },
            ));
    restClient.close();

    return BaseResponseTaskByDept.fromJson(result);
  }

  Future<BaseResponseAllTask> getTaskByProd(
      {Map<String, dynamic>? data}) async {
    final result =
        await restClient.request("${BASE_URL}taskbyprod/list", Method.GET, data,
            opt: Options(
              headers: {
                'requirestoken': true,
              },
            ));
    restClient.close();

    return BaseResponseAllTask.fromJson(result);
  }
}
