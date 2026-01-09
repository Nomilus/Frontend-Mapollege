import 'package:application_mapollege/config/router/routes.dart';
import 'package:application_mapollege/core/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserMiddleware extends GetMiddleware {
  @override
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    final userService = Get.find<AuthService>();

    if (userService.isChecking.value) {
      return RouteSettings(name: Routes.public.splash);
    }

    if (!userService.isLoggedIn.value) {
      return RouteSettings(name: Routes.public.auth);
    }

    return null;
  }
}
