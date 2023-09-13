import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/l10n/l10n.dart';

enum Difficulty {
  test, beginner, easy, normal, advanced, expert
}

extension DifficultyExt on Difficulty {
  static Difficulty fromString(String value) {
    switch (value) {
      case 'test':
        return Difficulty.test;
      case 'beginner':
        return Difficulty.beginner;
      case 'easy':
        return Difficulty.easy;
      case 'normal':
        return Difficulty.normal;
      case 'advanced':
        return Difficulty.advanced;
      case 'expert':
        return Difficulty.expert;
      default:
        return Difficulty.normal;
    }
  }

  static List<Difficulty> get playable => Difficulty.values.where((element) => kDebugMode || element != Difficulty.test).toList();

  String title(BuildContext context) {
    switch (this) {
      case Difficulty.test:
        return context.l10n.test;
      case Difficulty.beginner:
        return context.l10n.beginner;
      case Difficulty.easy:
        return context.l10n.easy;
      case Difficulty.normal:
        return context.l10n.normal;
      case Difficulty.advanced:
        return context.l10n.advanced;
      case Difficulty.expert:
        return context.l10n.expert;
    }
  }

  int get emptySquares {
    switch (this) {
      case Difficulty.test:
        return 1;
      case Difficulty.beginner:
        return 18;
      case Difficulty.easy:
        return 27;
      case Difficulty.normal:
        return 36;
      case Difficulty.advanced:
        return 42;
      case Difficulty.expert:
        return 54;
    }
  }
}
