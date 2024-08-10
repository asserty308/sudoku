part of 'difficulty_cubit.dart';

@immutable
sealed class DifficultyState {}

final class DifficultyInitial extends DifficultyState {}
final class DifficultyLoading extends DifficultyState {}
final class DifficultyLoaded extends DifficultyState {
  DifficultyLoaded({required this.difficulty});

  final Difficulty difficulty;
}
final class DifficultyError extends DifficultyState {}
