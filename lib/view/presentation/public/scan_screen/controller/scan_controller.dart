import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanController extends GetxController {
  late final MobileScannerController scannerController;

  final RxBool isScanned = false.obs;

  @override
  void onInit() {
    super.onInit();
    scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: [BarcodeFormat.qrCode],
    );
  }

  void onDetect(BarcodeCapture capture) {
    if (isScanned.value) return;

    final String? code = capture.barcodes.first.rawValue;
    if (code == null) return;

    isScanned.value = true;
    scannerController.stop();
    debugPrint("QR Code: $code");
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}
