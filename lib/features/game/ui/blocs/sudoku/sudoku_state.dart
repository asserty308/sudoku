part of 'sudoku_cubit.dart';

@immutable
sealed class const SudokuState();

final class const SudokuInitial() extends SudokuState;

final class const SudokuLoading() extends SudokuState;

final class const SudokuLoaded({
    required final SudokuModel model,
    required final DateTime timeStarted,
    required final Difficulty difficulty,
  }) extends SudokuState;
