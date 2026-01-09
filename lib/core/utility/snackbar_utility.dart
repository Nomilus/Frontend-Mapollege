import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtility {
  static TextButton _closeButton() {
    return TextButton(
      child: Text('Close', style: Get.theme.textTheme.bodyMedium),
      onPressed: () {
        if (Get.isSnackbarOpen) Get.back();
      },
    );
  }

  static void error({String? title, required String message}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
        mainButton: _closeButton(),
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
        mainButton: _closeButton(),
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
        mainButton: _closeButton(),
      );
    });
  }
}
