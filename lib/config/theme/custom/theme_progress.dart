import 'package:flutter/material.dart';

class ThemeProgress {
  ThemeProgress();

  ProgressIndicatorThemeData get progressIndicatorTheme =>
      const ProgressIndicatorThemeData(
        strokeCap: StrokeCap.round,
        strokeWidth: 3,
      );
}
