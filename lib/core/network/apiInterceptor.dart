import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as d;
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/controller/sessionController.dart';
import 'package:sitaris/feature/model/token/token.dart';

class DioLoggingInterceptors extends Interceptor {
  final Dio _dio;

  DioLoggingInterceptors(this._dio);
  SessionController _session = d.Get.find<SessionController>();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // print(options.data);
    // if (options.queryParameters != null) {
    //   // print("queryParameters:");
    //   options.queryParameters.forEach((k, v) => print('$k: $v'));
    // }
    if (options.data != null) {}

    if (options.headers.containsKey('requirestoken')) {
      options.headers.remove('requirestoken');

      String token = _session.accessToken!.value;
      // String token = await Session.getStringVal('accessToken');

      options.headers.addAll({
        "Authorization": "Bearer $token",
        "Access-Control-Allow-Origin":
            "*", // Required for CORS support to work,
        "Content-Type": "application/json",
        "Access-Control-Allow-Credentials":
            true, // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      });
    }
    // print('REQUEST[${options.method}] => PATH: ${options.path}');
    handler.next(options);
    // return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // print('RESPONSE[${response.statusCode}] => PATH: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response != null) {
        debugPrint('test interceptor');
        int responseCode = err.response!.statusCode!;
        if (responseCode == 401) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          _dio.interceptors.errorLock.lock();

          ApiRepository _apiRepo = new ApiRepository();
          Map<String, dynamic> _dataForRequest = {
            "grant_type": "client_credentials",
            "client_id": "test",
            "client_secret": "rahasia",
            "scope": "token"
          };
          TokenModel _token = await _apiRepo.postToken(data: _dataForRequest);
          String newAccessToken = _token.accessToken!;
          _session.setAccessToken(newAccessToken);

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          _dio.interceptors.errorLock.unlock();

          // _dio.interceptors.requestLock.lock();
          // _dio.interceptors.responseLock.lock();
          // _dio.interceptors.errorLock.lock();
          RequestOptions options = err.response!.requestOptions;

          options.headers
              .update("Authorization", (value) => "Bearer $newAccessToken");

          _dio
              .fetch(options)
              .then((value) => handler.resolve(value))
              .onError((error, stackTrace) => handler.reject(err));
          // return handler.next(err);
        } else {
          return handler.next(err);
        }
      } else {
        return handler.next(err);
      }
    } catch (e) {
      return handler.next(err);
    }
  }
  // return super.onError(err, handler);
}
