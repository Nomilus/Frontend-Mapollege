import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanLayoutController extends GetxController {
  late final MobileScannerController scannerController;

  final RxBool isScanned = false.obs;
  final RxBool isFlashOn = false.obs;

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

  Future<void> toggleFlash() async {
    await scannerController.toggleTorch();
    isFlashOn.toggle();
  }

  Future<void> onFlash() async {
    if (scannerController.value.torchState == TorchState.off) {
      await scannerController.toggleTorch();
      isFlashOn.toggle();
    }
  }

  Future<void> offFlash() async {
    if (scannerController.value.torchState == TorchState.on) {
      await scannerController.toggleTorch();
      isFlashOn.toggle();
    }
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}
