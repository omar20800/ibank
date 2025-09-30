import 'package:dio/dio.dart';
import 'package:ibank/core/constants/api_constants.dart';

class DioProvider {
  static late Dio _dio;

  static init() {
    _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  }

  static Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) {
    return _dio.get(endpoint, data: data, options: Options(headers: headers));
  }

  static Future<Response> post({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) {
    return _dio.post(endpoint, data: data, options: Options(headers: headers));
  }

  static Future<Response> update({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) {
    return _dio.put(endpoint, data: data, options: Options(headers: headers));
  }

  static Future<Response> delete({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) {
    return _dio.delete(
      endpoint,
      data: data,
      options: Options(headers: headers),
    );
  }
}
