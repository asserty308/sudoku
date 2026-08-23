part of 'difficulty_cubit.dart';

@immutable
sealed class const DifficultyState();

final class const DifficultyInitial() extends DifficultyState;

final class const DifficultyLoading() extends DifficultyState;

final class const DifficultyLoaded({required final Difficulty difficulty}) extends DifficultyState;

final class const DifficultyChanged({required final Difficulty difficulty}) extends DifficultyState;

final class const DifficultyError() extends DifficultyState;
