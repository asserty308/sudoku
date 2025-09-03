import 'package:flutter/material.dart';

ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  // fontFamily: _fontFamily,
  colorScheme: _colorScheme(false),
  textTheme: _textTheme,
  textButtonTheme: _textButtonTheme(false),
);

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  // fontFamily: _fontFamily,
  colorScheme: _colorScheme(true),
  textTheme: _textTheme,
  textButtonTheme: _textButtonTheme(true),
);

// const String _fontFamily = 'IndieFlower';

ColorScheme _colorScheme(bool isDarkMode) => ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
  brightness: isDarkMode ? Brightness.dark : Brightness.light,
);

TextTheme get _textTheme => TextTheme(bodyMedium: TextStyle(fontSize: 21));

TextButtonThemeData? _textButtonTheme(bool isDarkMode) => TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: isDarkMode
        ? Colors.white
        : Colors.black, // use default color on light mode
    disabledForegroundColor: isDarkMode
        ? Colors.white54
        : Colors.black54, // use default color on light mode
    // textStyle: TextStyle(fontFamily: _fontFamily),
  ),
);
