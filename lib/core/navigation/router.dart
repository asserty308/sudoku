import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/core/navigation/constants.dart';
import 'package:sudoku/features/game/ui/pages/game_page.dart';
import 'package:sudoku/features/leaderboard/ui/pages/leaderboard_page.dart';
import 'package:sudoku/features/settings/ui/pages/settings_page.dart';

final goRouterProvider = Provider(
  (ref) => GoRouter(
    restorationScopeId: 'router',
    routes: [
      GoRoute(
        path: kPathHome,
        name: kRouteHome,
        pageBuilder: (context, state) => const NoTransitionPage(
          restorationId: kRouteHome,
          child: GamePage(),
        ),
      ),
      GoRoute(
        path: kPathLeaderboard,
        name: kRouteLeaderboard,
        pageBuilder: (context, state) => const NoTransitionPage(
          restorationId: kRouteLeaderboard,
          child: LeaderboardPage(),
        ),
      ),
      GoRoute(
        path: kPathSettings,
        name: kRouteSettings,
        pageBuilder: (context, state) => const NoTransitionPage(
          restorationId: kRouteSettings,
          child: SettingsPage(),
        ),
      ),
    ],
  ),
);
