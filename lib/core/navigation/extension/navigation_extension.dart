import 'package:flutter/widgets.dart';
import 'package:sudoku/core/navigation/navigation_service.dart';

extension NavigationExtension on BuildContext {
  void goToHome() => NavigationService.goToHome(this);
  void goToLeaderboard() => NavigationService.goToLeaderboard(this);
  void goToSettings() => NavigationService.goToSettings(this);

  Future<T?> pushToLeaderboard<T>() =>
      NavigationService.pushToLeaderboard(this);
  Future<T?> pushToSettings<T>() => NavigationService.pushToSettings(this);

  void goBack() => NavigationService.goBack(this);
  void popWithResult<T>([T? result]) =>
      NavigationService.popWithResult(this, result);
  String? getCurrentRouteName() => NavigationService.getCurrentRouteName(this);
  String getCurrentRoutePath() => NavigationService.getCurrentRoutePath(this);
  bool isCurrentRoute(String routeName) =>
      NavigationService.isCurrentRoute(this, routeName);
  bool canGoBack() => NavigationService.canGoBack(this);
}
