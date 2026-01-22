import 'package:mapollege/view/presentation/public/splash_screen/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.start();

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
