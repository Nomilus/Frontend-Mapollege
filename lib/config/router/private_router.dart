import 'package:mapollege/config/middlewares/user_middleware.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/presentation/private/profile_screen/controller/profile_controller.dart';
import 'package:mapollege/view/presentation/private/profile_screen/screen/profile_screen.dart';

class PrivatePath {
  String get profile => "/private/profile";
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
  ];
}
