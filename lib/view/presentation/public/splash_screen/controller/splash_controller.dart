import 'package:application_mapollege/config/router/routes.dart';
import 'package:application_mapollege/core/service/auth_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final userService = Get.find<AuthService>();

  void start() {
    ever(userService.isChecking, (isChecking) {
      if (!isChecking) {
        if (userService.isLoggedIn.value) {
          Get.offAllNamed(Routes.public.home);
        } else {
          Get.offAllNamed(Routes.public.auth);
        }
      }
    });
  }
}
