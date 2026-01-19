import 'package:mapollege/config/router/routes.dart';
import 'package:get/get.dart';
import 'package:mapollege/core/service/auth_service.dart';

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
