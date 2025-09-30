import 'package:dio/dio.dart';

class DioProvider {
  static late Dio _dio;

  static init() {
    _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.13:8000/'));
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
