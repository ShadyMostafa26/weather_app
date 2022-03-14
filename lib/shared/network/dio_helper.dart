import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://www.metaweather.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({required String url,  Map<String, dynamic>? query}) async {
    dio.options.headers = {

    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
