import 'package:mapollege/config/middlewares/user_middleware.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/presentation/private/notification_screen/controller/notification_controller.dart';
import 'package:mapollege/view/presentation/private/notification_screen/screen/notification_screen.dart';
import 'package:mapollege/view/presentation/private/profile_screen/controller/profile_controller.dart';
import 'package:mapollege/view/presentation/private/profile_screen/screen/profile_screen.dart';

class PrivatePath {
  String get profile => "/private/profile";
  String get notification => "/private/notification";
}

class PrivateRouter extends PrivatePath {
  List<GetPage> get init => [
    GetPage(
      name: super.profile,
      page: () => const ProfileScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ProfileController>(() => ProfileController()),
      ),
      middlewares: [UserMiddleware()],
    ),
    GetPage(
      name: super.notification,
      page: () => const NotificationScreen(),
      binding: BindingsBuilder(
        () =>
            Get.lazyPut<NotificationController>(() => NotificationController()),
      ),
      middlewares: [UserMiddleware()],
    ),
  ];
}
