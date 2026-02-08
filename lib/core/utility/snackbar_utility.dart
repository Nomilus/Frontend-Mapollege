import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtility {
  static void bottom({required String message}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.rawSnackbar(
        message: message,
        barBlur: 7.0,
        shouldIconPulse: false,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.surfaceContainer.withValues(
          alpha: 0.5,
        ),
      );
    });
  }

  static void error({String? title, required String message, String? error}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint("SnackbarUtility error: $error");
      Get.snackbar(
        title ?? 'Error',
        message,
        barBlur: 7.0,
        shouldIconPulse: false,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.surfaceContainer.withValues(
          alpha: 0.5,
        ),
        icon: Icon(Icons.error, color: Get.theme.colorScheme.error),
      );
    });
  }

  static void success({String? title, required String message}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.snackbar(
        title ?? 'Success',
        message,
        barBlur: 7.0,
        shouldIconPulse: false,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.surfaceContainer.withValues(
          alpha: 0.5,
        ),
        icon: Icon(Icons.check_circle, color: Get.theme.colorScheme.primary),
      );
    });
  }

  static void info({String? title, required String message}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.snackbar(
        title ?? 'Info',
        message,
        barBlur: 7.0,
        shouldIconPulse: false,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.surfaceContainer.withValues(
          alpha: 0.5,
        ),
        icon: Icon(Icons.info, color: Get.theme.colorScheme.secondary),
      );
    });
  }
}
