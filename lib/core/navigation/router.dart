import 'package:go_router/go_router.dart';
import 'package:sudoku/core/navigation/routes.dart';
import 'package:sudoku/features/game/ui/pages/game_page.dart';
import 'package:sudoku/features/leaderboard/ui/pages/leaderboard_page.dart';
import 'package:sudoku/features/settings/ui/pages/settings_page.dart';

class AppRouter {
  AppRouter._();

  static final instance = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: kRouteHome,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: GamePage()),
      ),
      GoRoute(
        path: '/leaderboard',
        name: kRouteLeaderboard,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LeaderboardPage()),
      ),
      GoRoute(
        path: '/settings',
        name: kRouteSettings,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SettingsPage()),
      ),
    ],
  );
}
