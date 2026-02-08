import 'package:mapollege/view/presentation/public/auth_screen/controller/auth_controller.dart';
import 'package:mapollege/view/presentation/public/auth_screen/screen/auth_screen.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/home_controller.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/layout_controller/main_layout_controller.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/widget_controller/map_widget_controller.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/widget_controller/panel_widget_controller.dart';
import 'package:mapollege/view/presentation/public/home_screen/screen/home_screen.dart';
import 'package:mapollege/view/presentation/public/notification_screen/controller/notification_controller.dart';
import 'package:mapollege/view/presentation/public/notification_screen/screen/notification_screen.dart';
import 'package:mapollege/view/presentation/public/room_screen/controller/room_controller.dart';
import 'package:mapollege/view/presentation/public/room_screen/screen/room_screen.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/layout_controller/scan_layout_controller.dart';
import 'package:mapollege/view/presentation/public/search_screen/controller/search_controller.dart';
import 'package:mapollege/view/presentation/public/search_screen/screen/search_screen.dart';
import 'package:mapollege/view/presentation/public/splash_screen/controller/splash_controller.dart';
import 'package:mapollege/view/presentation/public/splash_screen/screen/splash_screen.dart';
import 'package:get/get.dart';

class PublicPath {
  String get auth => "/public/auth";
  String get home => "/public/home";
  String get notification => "/public/notification";
  String get room => "/public/room";
  String get search => "/public/search";
  String get splash => "/public/splash";
}

class PublicRouter extends PublicPath {
  List<GetPage> get init => [
    GetPage(
      name: super.auth,
      page: () => const AuthScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: super.home,
      page: () => const HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());

        Get.lazyPut<MainLayoutController>(() => MainLayoutController());
        Get.lazyPut<ScanLayoutController>(() => ScanLayoutController());

        Get.lazyPut<MapWidgetController>(() => MapWidgetController());
        Get.lazyPut<PanelWidgetController>(() => PanelWidgetController());
      }),
    ),
    GetPage(
      name: super.notification,
      page: () => const NotificationScreen(),
      binding: BindingsBuilder(
        () =>
            Get.lazyPut<NotificationController>(() => NotificationController()),
      ),
    ),
    GetPage(
      name: super.room,
      page: () => const RoomScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RoomController>(() => RoomController());
      }),
    ),
    GetPage(
      name: super.search,
      page: () => const SearchScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SearchGetController>(() => SearchGetController());
      }),
    ),
    GetPage(
      name: super.splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SplashController>(() => SplashController()),
      ),
    ),
  ];
}
