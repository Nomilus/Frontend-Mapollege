import 'package:mapollege/config/router/routes.dart';
import 'package:mapollege/core/service/auth_service.dart';
import 'package:mapollege/core/service/theme_service.dart';
import 'package:get/get.dart';
import 'package:mapollege/core/utility/overlay_utility.dart';

class AuthController extends GetxController {
  final ThemeService _themeService = Get.find<ThemeService>();
  final AuthService _authService = Get.find<AuthService>();

  void get toggleTheme =>
      _themeService.toggleThemeApp(value: !_themeService.isDarkMode.value);
  bool get isTheme => _themeService.isDarkMode.value;

  Future<void> signIn() async {
    OverlayUtility.showLoading();
    await _authService.signInGoogle();

    if (_authService.isLoggedIn.value) {
      Get.toNamed(Routes.public.home);
    }
    OverlayUtility.hideOverlay();
  }
}
