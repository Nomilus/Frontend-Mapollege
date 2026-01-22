import 'package:mapollege/view/presentation/public/scan_screen/controller/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanScreen extends GetView<ScanController> {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        controller: controller.scannerController,
        onDetect: controller.onDetect,
      ),
    );
  }
}
