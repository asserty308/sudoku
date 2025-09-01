import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/app/data/providers/providers.dart';
import 'package:sudoku/app/leaderboard/domain/use_cases/get_leaderboard_use_case.dart';

final getLeaderboardProvider = Provider(
  (ref) => GetLeaderboardUseCase(sharedPrefs: ref.read(sharedPrefsProvider)),
);
