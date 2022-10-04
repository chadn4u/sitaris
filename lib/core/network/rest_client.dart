// ignore_for_file: constant_identifier_names, unused_catch_clause

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'dart:io';

import 'package:sitaris/feature/controller/sessionController.dart';

import 'apiInterceptor.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

const BASE_URL = "https://sitaris.web.id/api/v1/";
const BASE_URL_TOKEN = "https://sitaris.web.id/";

class RestClient extends GetxService {
  late d.Dio _dio;
  late bool connectionClose;

  static header() => {
        'Content-Type': 'application/json',
      };

  Future<RestClient> init() async {
    _dio = d.Dio();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    _dio.options.connectTimeout = 30000;
    _dio.options.receiveTimeout = 30000;
    _dio.interceptors.add(d.LogInterceptor(responseBody: true));
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
    connectionClose = false;
  }

  Future<dynamic> request(
      String url, Method method, Map<String, dynamic>? params,
      {Options? opt}) async {
    d.Response response;
    if (connectionClose) {
      init();
    }
    debugPrint(params.toString());
    try {
      if (method == Method.POST) {
        response = await _dio.post(url, data: params, options: opt);
      } else if (method == Method.DELETE) {
        response = await _dio.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio.patch(url);
      } else {
        response = await _dio.get(url, queryParameters: params, options: opt);
      }

      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something Went Wrong");
      }
    } on SocketException catch (e) {
      throw Exception("No Internet Connection");
    } on FormatException {
      throw Exception("Bad Response Format!");
    } on d.DioError catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }

  void close() {
    _dio.close();
    connectionClose = true;
  }
}
