import 'package:mapollege/config/middlewares/admin_middleware.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/presentation/admin/dashboard_screen/controller/dashboard_controller.dart';
import 'package:mapollege/view/presentation/admin/dashboard_screen/screen/dashboard_screen.dart';

class AdminPath {
  String get dashboard => "/admin/dashboard";
}

class AdminRouter extends AdminPath {
   List<GetPage> get init => [
    GetPage(
      name: super.dashboard,
      page: () => const DashboardScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<DashboardController>(() => DashboardController()),
      ),
      middlewares: [AdminMiddleware()],
    ),
  ];
}
