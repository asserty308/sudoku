import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sudoku/app/leaderboard/domain/use_cases/get_leaderboard_use_case.dart';
import 'package:sudoku/game/data/models/leaderboard_entry_model.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit({required this.getLeaderboardUseCase})
    : super(LeaderboardStateInitial());

  final GetLeaderboardUseCase getLeaderboardUseCase;

  /// Loads the leaderboard of the currently selected difficulty.
  /// Emits specific error states based on the error type.
  Future<void> getLeaderboard() async {
    if (state is LeaderboardStateLoading) {
      return; // Prevent multiple simultaneous requests
    }

    emit(LeaderboardStateLoading());

    try {
      final results = await getLeaderboardUseCase.execute();
      emit(LeaderboardStateLoaded(results: results));
    } catch (e) {
      logger.e('Error loading leaderboard', error: e);
      emit(_handleError(e));
    }
  }

  /// Refresh the leaderboard data
  Future<void> refresh() async {
    await getLeaderboard();
  }

  LeaderboardStateError _handleError(dynamic error) {
    if (error is SocketException || error is HttpException) {
      return LeaderboardStateError(
        errorType: LeaderboardErrorType.network,
        message: 'Network connection failed',
      );
    } else if (error is FormatException ||
        error.toString().contains('storage')) {
      return LeaderboardStateError(
        errorType: LeaderboardErrorType.storage,
        message: 'Failed to access local data',
      );
    } else {
      return LeaderboardStateError(
        errorType: LeaderboardErrorType.unknown,
        message: error.toString(),
      );
    }
  }
}
