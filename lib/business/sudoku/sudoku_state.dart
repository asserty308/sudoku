part of 'sudoku_cubit.dart';

@immutable
sealed class SudokuState {}

final class SudokuInitial extends SudokuState {}
final class SudokuLoading extends SudokuState {}

final class SudokuLoaded extends SudokuState {
  SudokuLoaded({required this.model});

  final SudokuModel model;
}
