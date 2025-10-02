import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/core/navigation/routes.dart';

/// Navigation service for type-safe navigation throughout the app
class NavigationService {
  /// Navigate to home page
  static void goToHome(BuildContext context) {
    context.goNamed(kRouteHome);
  }

  /// Navigate to leaderboard page
  static void goToLeaderboard(BuildContext context) {
    context.goNamed(kRouteLeaderboard);
  }

  /// Navigate to settings page
  static void goToSettings(BuildContext context) {
    context.goNamed(kRouteSettings);
  }

  /// Push a route (for modals, dialogs, etc.)
  static Future<T?> pushToLeaderboard<T>(BuildContext context) =>
      context.pushNamed<T>(kRouteLeaderboard);

  /// Push a route (for modals, dialogs, etc.)
  static Future<T?> pushToSettings<T>(BuildContext context) =>
      context.pushNamed<T>(kRouteSettings);

  /// Navigate back
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      // If can't pop, go to home
      goToHome(context);
    }
  }

  /// Pop with result (for dialogs)
  static void popWithResult<T>(BuildContext context, [T? result]) {
    context.pop<T>(result);
  }

  /// Get current route name
  static String? getCurrentRouteName(BuildContext context) {
    final routeData = GoRouterState.of(context);
    return routeData.name;
  }

  /// Get current route path
  static String getCurrentRoutePath(BuildContext context) {
    final routeData = GoRouterState.of(context);
    return routeData.path ?? '/';
  }

  /// Check if current route is the given route
  static bool isCurrentRoute(BuildContext context, String routeName) {
    return getCurrentRouteName(context) == routeName;
  }

  /// Check if we can navigate back
  static bool canGoBack(BuildContext context) {
    return context.canPop();
  }
}
