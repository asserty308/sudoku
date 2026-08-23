import 'package:flutter_core/flutter_core.dart';
import 'package:material_ui/material_ui.dart';

extension ThemeExt on BuildContext {
  bool get isDarkMode => theme.brightness == Brightness.dark;
}
