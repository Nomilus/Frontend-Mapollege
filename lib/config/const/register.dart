import 'package:mapollege/core/service/auth_service.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/service/location_service.dart';
import 'package:mapollege/core/service/theme_service.dart';
import 'package:get/get.dart';

class Register {
  Future<void> get init async {
    Get.lazyPut(() => AuthService());
    await Get.putAsync<DioService>(() async {
      final service = DioService();
      await service.init();
      return service;
    });
    Get.lazyPut(() => LocationService());
    Get.lazyPut(() => ThemeService());
  }
}
