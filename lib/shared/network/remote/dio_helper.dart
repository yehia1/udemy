import 'package:dio/dio.dart';

class DioHelper
{
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async
  {
    dio.options.headers = {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async{
    dio.options.headers = {
        'lang':lang,
        'Content-Type':'application/json',
        'Authorization': token,
      };
    return dio.post(url,data: data,queryParameters: query);
  }


  static Future<Response> updateData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}