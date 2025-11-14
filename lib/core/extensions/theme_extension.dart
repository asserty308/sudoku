import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

extension ThemeExt on BuildContext {
  bool get isDarkMode => theme.brightness == Brightness.dark;
}
