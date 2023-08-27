import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  Size get mediaSize => MediaQuery.of(this).size;
  bool get isDarkMode => MediaQuery.of(this).platformBrightness == Brightness.dark;
}