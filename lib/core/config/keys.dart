import 'package:sudoku/features/game/data/models/difficulty.dart';

const keyDifficulty = 'difficulty';
const keyPreferredTheme = 'preferred_theme';
String leaderboardDifficultyKey(Difficulty difficulty) =>
    'leaderboard_${difficulty.name}';
