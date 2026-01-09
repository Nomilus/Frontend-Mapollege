import 'package:application_mapollege/config/middlewares/admin_middleware.dart';
import 'package:application_mapollege/view/presentation/admin/dashboard_screen/controller/dashboard_controller.dart';
import 'package:application_mapollege/view/presentation/admin/dashboard_screen/screen/dashboard_screen.dart';
import 'package:get/get.dart';

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
