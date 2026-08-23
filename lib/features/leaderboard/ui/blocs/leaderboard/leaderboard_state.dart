part of 'leaderboard_cubit.dart';

@immutable
sealed class const LeaderboardState();

final class const LeaderboardStateInitial() extends LeaderboardState;

final class const LeaderboardStateLoading() extends LeaderboardState;

final class const LeaderboardStateLoaded({required final List<LeaderboardEntryModel> results}) extends LeaderboardState;

final class const LeaderboardStateError({required final LeaderboardErrorType errorType, final String? message}) extends LeaderboardState;

enum LeaderboardErrorType() { network, storage, unknown }
