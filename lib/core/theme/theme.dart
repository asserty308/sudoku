import 'package:flutter/material.dart';

const Color _kSeedColor = Colors.deepPurple;

final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
  seedColor: _kSeedColor,
  brightness: Brightness.light,
);

final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
  seedColor: _kSeedColor,
  brightness: Brightness.dark,
);

const TextTheme _kTextTheme = TextTheme(bodyMedium: TextStyle(fontSize: 21));

final TextButtonThemeData _lightTextButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: Colors.black,
    disabledForegroundColor: Colors.black54,
  ),
);

final TextButtonThemeData _darkTextButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: Colors.white,
    disabledForegroundColor: Colors.white54,
  ),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _lightColorScheme,
  textTheme: _kTextTheme,
  textButtonTheme: _lightTextButtonTheme,
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _darkColorScheme,
  textTheme: _kTextTheme,
  textButtonTheme: _darkTextButtonTheme,
);
