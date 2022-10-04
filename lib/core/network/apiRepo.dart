import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/core/network/rest_client.dart';
import 'package:sitaris/feature/model/city/city.dart';
import 'package:sitaris/feature/model/kecamatan/kecamatan.dart';
import 'package:sitaris/feature/model/kelurahan/kelurahan.dart';
import 'package:sitaris/feature/model/login/login.dart';
import 'package:sitaris/feature/model/product/product.dart';
import 'package:sitaris/feature/model/province/province.dart';
import 'package:sitaris/feature/model/token/token.dart';

class ApiRepository {
  late RestClient restClient;
  ApiRepository() {
    restClient = Get.find();
  }
  Future<TokenModel> postToken({Map<String, dynamic>? data}) async {
    final result = await restClient.request(
        "${BASE_URL_TOKEN}authorize/client_credentials", Method.POST, data);

    debugPrint(result.toString());
    restClient.close();

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

  Future<BaseResponseKelurahan> getKelurahan(
      {Map<String, dynamic>? data}) async {
    final result = await restClient.request(
        "${BASE_URL}listkelurahan/all", Method.GET, data,
        opt: Options(
          headers: {
            'requirestoken': true,
          },
        ));
    restClient.close();

    return BaseResponseKelurahan.fromJson(result);
  }

  Future<BaseResponseKecamatan> getKecamatan(
      {Map<String, dynamic>? data}) async {
    final result = await restClient.request(
        "${BASE_URL}listkecamatan/all", Method.GET, data,
        opt: Options(
          headers: {
            'requirestoken': true,
          },
        ));
    restClient.close();

    return BaseResponseKecamatan.fromJson(result);
  }

  Future<BaseResponseCity> getCity({Map<String, dynamic>? data}) async {
    final result =
        await restClient.request("${BASE_URL}listcity/all", Method.GET, data,
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
}