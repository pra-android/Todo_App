import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final box = GetStorage();
  final key = 'isDarkMode';
  _savethemefromBox(bool isDarkMode) => box.write(key, isDarkMode);
  bool loadthemeFromBox() {
    return box.read(key) ?? false;
  }

  ThemeMode get theme => loadthemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchtheme() {
    Get.changeThemeMode(loadthemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _savethemefromBox(!loadthemeFromBox());
  }
}
