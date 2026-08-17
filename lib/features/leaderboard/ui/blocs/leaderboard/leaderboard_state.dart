part of 'leaderboard_cubit.dart';

@immutable
sealed class LeaderboardState;

final class LeaderboardStateInitial extends LeaderboardState;

final class LeaderboardStateLoading extends LeaderboardState;

final class LeaderboardStateLoaded extends LeaderboardState {
  new({required this.results});

  final List<LeaderboardEntryModel> results;
}

final class LeaderboardStateError extends LeaderboardState {
  new({required this.errorType, this.message});

  final LeaderboardErrorType errorType;
  final String? message;
}

enum LeaderboardErrorType { network, storage, unknown }
