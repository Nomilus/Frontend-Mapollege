import 'package:flutter/material.dart';

class ThemeButton {
  ThemeButton({required this.colorScheme, required this.textTheme});

  final ColorScheme colorScheme;
  final TextTheme textTheme;

  IconButtonThemeData get iconButtonTheme => IconButtonThemeData(
    style: IconButton.styleFrom(shape: const CircleBorder()),
  );

  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      textStyle: textTheme.titleSmall,
      backgroundColor: colorScheme.surfaceContainer,
      shadowColor: Colors.black,
      elevation: 2,
    ),
  );

  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      textStyle: textTheme.titleSmall,
    ),
  );

  FloatingActionButtonThemeData get floatingActionButtonTheme =>
      FloatingActionButtonThemeData(
        shape: const CircleBorder(),
        backgroundColor: colorScheme.surfaceContainer,
        elevation: 2,
      );
}
