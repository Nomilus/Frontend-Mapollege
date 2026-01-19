import 'package:mapollege/view/presentation/public/auth_screen/controller/auth_controller.dart';
import 'package:mapollege/view/presentation/public/auth_screen/screen/auth_screen.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/panel_controller.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/home_controller.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/map_controller.dart';
import 'package:mapollege/view/presentation/public/home_screen/screen/home_screen.dart';
import 'package:mapollege/view/presentation/public/room_screen/controller/room_controller.dart';
import 'package:mapollege/view/presentation/public/room_screen/screen/room_screen.dart';
import 'package:mapollege/view/presentation/public/scan_screen/controller/scan_controller.dart';
import 'package:mapollege/view/presentation/public/scan_screen/screen/scan_screen.dart';
import 'package:mapollege/view/presentation/public/splash_screen/controller/splash_controller.dart';
import 'package:mapollege/view/presentation/public/splash_screen/screen/splash_screen.dart';
import 'package:get/get.dart';

class PublicPath {
  String get home => "/public/home";
  String get room => "/public/room";
  String get auth => "/public/auth";
  String get splash => "/public/splash";
  String get scanner => "/public/scanner";
}

class PublicRouter extends PublicPath {
  List<GetPage> get init => [
    GetPage(
      name: super.home,
      page: () => HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
        Get.lazyPut<MapController>(() => MapController());
        Get.lazyPut<PanelController>(() => PanelController());
      }),
    ),
    GetPage(
      name: super.room,
      page: () => const RoomScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RoomController>(() => RoomController());
      }),
    ),
    GetPage(
      name: super.auth,
      page: () => const AuthScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: super.splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SplashController>(() => SplashController()),
      ),
    ),
    GetPage(
      name: super.scanner,
      page: () => const ScanScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ScanController>(() => ScanController()),
      ),
    ),
  ];
}
