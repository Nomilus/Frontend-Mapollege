import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/home_controller.dart';
import 'package:mapollege/view/presentation/public/home_screen/layout/main_layout.dart';
import 'package:mapollege/view/presentation/public/home_screen/layout/scan_layout.dart';
import 'package:mapollege/view/presentation/public/home_screen/widget/home_floating_widget.dart';
import 'package:mapollege/view/presentation/public/home_screen/widget/home_navigation_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [MainLayout(), ScanLayout()],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const HomeFloatingWidget(),
      bottomNavigationBar: const HomeNavigationWidget(),
    );
  }
}
