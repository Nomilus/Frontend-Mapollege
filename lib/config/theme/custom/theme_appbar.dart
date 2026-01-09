import 'package:flutter/material.dart';

class ThemeAppBar {
  ThemeAppBar({required this.colorScheme});

  final ColorScheme colorScheme;

  AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: colorScheme.surface,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 4,
    elevation: 0,
  );
}
