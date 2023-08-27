enum Difficulty {
  test, beginner, easy, normal, advanced, expert
}

extension DifficultyExt on Difficulty {
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
}
