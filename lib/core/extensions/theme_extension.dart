import 'package:flutter/material.dart';

extension ThemeExt on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
