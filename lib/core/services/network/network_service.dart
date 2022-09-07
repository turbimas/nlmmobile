import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';

abstract class NetworkService {
  static late final Dio _dio;
  static const debug = true;

  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://api.goldenerp.com/',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        contentType: Headers.jsonContentType,
      ),
    );
  }

  static Future<ResponseModel<T>> get<T>(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      if (debug) {
        log("GET : $url");
      }
      Response<Map<String, dynamic>> data =
          await _dio.get<Map<String, dynamic>>(
        url,
        queryParameters: queryParameters,
      );
      if (debug) {
        log("GET DATA: ${data.data}");
      }
      return ResponseModel<T>.fromJson(data.data!);
    } catch (e) {
      if (debug) {
        log("GET ERROR: $e");
      }
      return ResponseModel<T>.error();
    }
  }

  static Future<ResponseModel<T>> post<T>(String url,
      {Map<String, dynamic>? queryParameters, dynamic body}) async {
    try {
      if (debug) {
        log("POST: $url");
        log("POST BODY: $body");
      }
      Response<Map<String, dynamic>> response =
          await _dio.post<Map<String, dynamic>>(
        url,
        queryParameters: queryParameters,
        data: body,
      );
      if (debug) {
        log("POST DATA: ${response.data}");
      }
      return ResponseModel<T>.fromJson(response.data!);
    } catch (e) {
      if (debug) {
        log("POST ERROR: $e");
      }

      return ResponseModel.error();
    }
  }
}
