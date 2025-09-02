import 'package:sudoku/game/data/models/difficulty.dart';

const kDifficultyKey = 'difficulty';
const kPreferredThemeKey = 'preferred_theme';
String leaderboardDifficultyKey(Difficulty difficulty) =>
    'leaderboard_${difficulty.name}';
