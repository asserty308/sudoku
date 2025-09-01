part of 'leaderboard_cubit.dart';

@immutable
sealed class LeaderboardState {}

final class LeaderboardInitial extends LeaderboardState {}
final class LeaderboardLoading extends LeaderboardState {}
final class LeaderboardLoaded extends LeaderboardState {
  LeaderboardLoaded({required this.results});

  final List<LeaderboardEntryModel> results;
}
final class LeaderboardError extends LeaderboardState {}
