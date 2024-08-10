import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/game/data/models/difficulty.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit() : super(LeaderboardInitial());

  Future<void> getLeaderboard(Difficulty difficulty) async {
    
  }
}
