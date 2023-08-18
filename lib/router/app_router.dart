import 'package:go_router/go_router.dart';
import 'package:sudoku/ui/pages/game_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const NoTransitionPage(child: GamePage()),
    )
  ]
);