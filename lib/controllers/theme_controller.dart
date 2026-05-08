import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;

  ThemeMode get themeMode => _themeMode.value;

  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  void setLightMode() {
    _themeMode.value = ThemeMode.light;
  }

  void setDarkMode() {
    _themeMode.value = ThemeMode.dark;
  }
}
