import 'package:flutter/material.dart';
import 'package:sudoku/app/services/theme.dart';

extension AppColors on Colors {
  static Color fieldBg1(BuildContext context) => context.isDarkMode ? Colors.blueGrey.shade800 : Colors.amber.shade100;
  static Color fieldBg2(BuildContext context) => context.isDarkMode ? Colors.blueGrey.shade700 : Colors.amber.shade50;
  static Color selectedField(BuildContext context) => context.isDarkMode ? Colors.blueGrey : Colors.amber;
}