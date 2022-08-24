import 'package:dio/dio.dart';
import 'package:life/constants/constants.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(

      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? query,
    String? lang='en',
    String? token,
  }) async {
    dio!.options.headers=
    {
      'lang' : lang,
      'authorization':'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio!.get(endPoint, queryParameters: query);
  }

  static Future<Response> postData({
    required String endPoint,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang='en',
    String? token,
  }) async {
    dio!.options.headers=
    {
      'lang' : lang,
      'authorization':'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio!.post(endPoint, queryParameters: query, data: data);
  }


  // static Future<Response> putData({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   required Map<String, dynamic> data,
  //   String? lang='en',
  //   String? token,
  // }) async {
  //   dio!.options.headers=
  //   {
  //     'lang' : lang,
  //     'Authorization':token,
  //   };
  //   return await dio!.put(url, queryParameters: query, data: data);
  // }

  static Future<Response> patchData({
    required String endPoint,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang='en',
    String? token,
  }) async {
    dio!.options.headers=
    {
      'lang' : lang,
      'authorization':'Bearer $token',
    };
    return await dio!.patch(endPoint, queryParameters: query, data: data);
  }
}
