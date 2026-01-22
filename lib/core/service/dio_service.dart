import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DioService extends GetxService {
  late final SharedPreferences _prefs;
  late final Dio dio;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_URL']!,
        connectTimeout: const Duration(seconds: 15),
        headers: {'ngrok-skip-browser-warning': 'true'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _prefs.getString('access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }
}
