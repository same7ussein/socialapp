import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'}));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    String lang = 'ar',
    String? token,
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return await dio.post(url, data: data);
  }

  static Future<Response> putData({
    String lang = 'ar',
    required String token,
    required String url,
    required Map<String, dynamic> data,
    required Map<String, dynamic> query,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return await dio.put(url, data: data);
  }
}
