import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class DialogUtility {
  static void showImage(dynamic image) {
    Get.dialog(
      useSafeArea: false,
      PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Get.back();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                  child: Container(color: Colors.black.withValues(alpha: 0.5)),
                ),
              ),

              Positioned.fill(
                child: PhotoView(
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  initialScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 2.5,
                  minScale: PhotoViewComputedScale.contained,
                  imageProvider: (image is File)
                      ? FileImage(image)
                      : NetworkImage(image.toString()),
                ),
              ),

              Positioned(
                top: 16,
                left: 16,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                    style: ButtonStyle(
                      shadowColor: const WidgetStatePropertyAll(Colors.black),
                      elevation: const WidgetStatePropertyAll(2),
                      backgroundColor: WidgetStatePropertyAll(
                        Get.theme.colorScheme.surfaceContainerHighest,
                      ),
                      foregroundColor: WidgetStatePropertyAll(
                        Get.theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
