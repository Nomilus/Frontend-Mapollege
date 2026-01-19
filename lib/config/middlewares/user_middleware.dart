import 'package:mapollege/config/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/core/service/auth_service.dart';

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
