import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/l10n/l10n.dart';

enum Difficulty {
  test, beginner, easy, normal, advanced, expert
}

extension DifficultyExt on Difficulty {
  static Difficulty fromString(String value) => Difficulty.values.firstWhere((e) => e.name == value, orElse: () => Difficulty.normal,);

  /// Difficulties selectable by the user.
  /// 
  /// test will only be availabe on debug mode.
  static Set<Difficulty> get playable => Difficulty.values
    .where((element) => kDebugMode || element != Difficulty.test)
    .toSet();

  String title(BuildContext context) => switch (this) {
    Difficulty.test => context.l10n.test,
    Difficulty.beginner => context.l10n.beginner,
    Difficulty.easy => context.l10n.easy,
    Difficulty.normal => context.l10n.normal,
    Difficulty.advanced => context.l10n.advanced,
    Difficulty.expert => context.l10n.expert,
  };

  int get emptySquares => switch (this) {
    Difficulty.test => 1,
    Difficulty.beginner => 18,
    Difficulty.easy => 27,
    Difficulty.normal => 36,
    Difficulty.advanced => 42,
    Difficulty.expert => 54,
  };
}
