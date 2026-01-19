import 'package:mapollege/config/router/routes.dart';
import 'package:mapollege/core/model/people/user_model.dart';
import 'package:mapollege/core/service/auth_service.dart';
import 'package:mapollege/core/service/theme_service.dart';
import 'package:get/get.dart';
import 'package:mapollege/core/utility/overlay_utility.dart';

class ProfileController extends GetxController {
  final ThemeService _themeService = Get.find<ThemeService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxBool isLoading = false.obs;

  UserModel? get currentUser => _authService.currentUser.value;
  bool get isTheme => _themeService.isDarkMode.value;
  void get toggleTheme =>
      _themeService.toggleThemeApp(value: !_themeService.isDarkMode.value);

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Future<void> refreshUser() async => _authService.currentUser.refresh();

  Future<void> signOut() async {
    OverlayUtility.showLoading();
    await _authService.signOutGoogle();
    Get.offAllNamed(Routes.public.home);
    OverlayUtility.hideOverlay();
  }
}
