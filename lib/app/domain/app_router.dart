import 'package:go_router/go_router.dart';
import 'package:sudoku/game/ui/pages/game_page.dart';
import 'package:sudoku/game/ui/pages/leaderboard_page.dart';
import 'package:sudoku/settings/ui/pages/settings_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const NoTransitionPage(child: GamePage()),
    ),
    GoRoute(
      path: '/leaderboard',
      pageBuilder: (context, state) => const NoTransitionPage(child: LeaderboardPage()),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => const NoTransitionPage(child: SettingsPage()),
    )
  ]
);
