import 'package:flutter/services.dart';

class HandleKeyboadInputUseCase {
  /// Returns the entered number when a number between 1-9 is entered.
  /// Returns 0 otherwise.
  int execute(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return 0;
    }

    return switch (event.logicalKey) {
      LogicalKeyboardKey.digit1 || LogicalKeyboardKey.numpad1 => 1,
      LogicalKeyboardKey.digit2 || LogicalKeyboardKey.numpad2 => 2,
      LogicalKeyboardKey.digit3 || LogicalKeyboardKey.numpad3 => 3,
      LogicalKeyboardKey.digit4 || LogicalKeyboardKey.numpad4 => 4,
      LogicalKeyboardKey.digit5 || LogicalKeyboardKey.numpad5 => 5,
      LogicalKeyboardKey.digit6 || LogicalKeyboardKey.numpad6 => 6,
      LogicalKeyboardKey.digit7 || LogicalKeyboardKey.numpad7 => 7,
      LogicalKeyboardKey.digit8 || LogicalKeyboardKey.numpad8 => 8,
      LogicalKeyboardKey.digit9 || LogicalKeyboardKey.numpad9 => 9,
      _ => 0,
    };
  }
}
