import 'package:flutter/material.dart';

class ThemeSearchbar {
  ThemeSearchbar({required this.colorScheme, required this.textTheme});

  final ColorScheme colorScheme;
  final TextTheme textTheme;

  SearchBarThemeData get searchBarTheme => SearchBarThemeData(
    constraints: const BoxConstraints(minHeight: 40, maxHeight: 100),
    shadowColor: const WidgetStatePropertyAll(Colors.black),
    elevation: const WidgetStatePropertyAll(2),
    backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceContainer),
    textStyle: WidgetStatePropertyAll(textTheme.bodyMedium),
    hintStyle: WidgetStatePropertyAll(textTheme.bodyMedium),
  );
}
