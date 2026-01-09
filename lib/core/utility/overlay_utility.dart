import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverlayUtility {
  static OverlayEntry? _overlayEntry;

  static void showLoading() {
    if (_overlayEntry != null) {
      return;
    }

    if (Get.overlayContext == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showOverlayLoading();
      });
    } else {
      _showOverlayLoading();
    }
  }

  static void hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  static void _showOverlayLoading() {
    if (Get.overlayContext == null || _overlayEntry != null) return;

    final overlayEntry = OverlayEntry(
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
          child: ColoredBox(
            color: Colors.black.withValues(alpha: 0.5),
            child: const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );

    _overlayEntry = overlayEntry;

    Overlay.of(Get.overlayContext!).insert(overlayEntry);
  }
}
