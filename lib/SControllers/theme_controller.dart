import 'package:ai_chat/Utility/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  ThemeData get currentTheme => isDarkMode.value ? darkTheme : lightTheme;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}
