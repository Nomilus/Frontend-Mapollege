import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends GetxService {
  late final SharedPreferences _prefs;
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  void _initialize() async {
    _prefs = await SharedPreferences.getInstance();
    final isDark = _prefs.getBool('darkTheme') ?? false;
    isDarkMode(isDark);
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleThemeApp({required bool value}) async {
    isDarkMode(value);
    await _prefs.setBool('darkTheme', value);
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}
