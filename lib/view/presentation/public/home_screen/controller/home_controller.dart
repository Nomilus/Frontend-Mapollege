import 'package:application_mapollege/core/model/people/user_model.dart';
import 'package:application_mapollege/core/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  AnimationController? refreshController;

  UserModel? get currentUser =>
      _authService.isLoggedIn.value ? _authService.currentUser.value : null;
  final RxBool isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
