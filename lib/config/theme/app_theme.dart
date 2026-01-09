import 'package:application_mapollege/config/theme/custom/theme_appbar.dart';
import 'package:application_mapollege/config/theme/custom/theme_button.dart';
import 'package:application_mapollege/config/theme/custom/theme_color.dart';
import 'package:application_mapollege/config/theme/custom/theme_font.dart';
import 'package:application_mapollege/config/theme/custom/theme_input.dart';
import 'package:application_mapollege/config/theme/custom/theme_progress.dart';
import 'package:application_mapollege/config/theme/custom/theme_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeApp {
  ThemeApp() : _themeColor = ThemeColor(), _themeFont = const ThemeFont();

  final ThemeColor _themeColor;
  final ThemeFont _themeFont;

  ThemeData get getLightTheme => _getTheme(_themeColor.lightScheme);
  ThemeData get getDarkTheme => _getTheme(_themeColor.darkScheme);

  ThemeData _getTheme(ColorScheme colorScheme) {
    final TextTheme textTheme = _themeFont.textTheme;
    final ThemeButton themeButton = ThemeButton(
      colorScheme: colorScheme,
      textTheme: textTheme,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontFamilyFallback: [GoogleFonts.kanit().fontFamily!],
      textTheme: textTheme,
      appBarTheme: ThemeAppBar(colorScheme: colorScheme).appBarTheme,
      progressIndicatorTheme: ThemeProgress().progressIndicatorTheme,
      searchBarTheme: ThemeSearchbar(
        colorScheme: colorScheme,
        textTheme: textTheme,
      ).searchBarTheme,
      inputDecorationTheme: ThemeInput(
        colorScheme: colorScheme,
      ).inputDecorationTheme,
      iconButtonTheme: themeButton.iconButtonTheme,
      elevatedButtonTheme: themeButton.elevatedButtonTheme,
      outlinedButtonTheme: themeButton.outlinedButtonTheme,
      floatingActionButtonTheme: themeButton.floatingActionButtonTheme,
    );
  }
}
