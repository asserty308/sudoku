// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get difficulty => 'Difficulty';

  @override
  String get test => 'Test';

  @override
  String get beginner => 'Beginner';

  @override
  String get easy => 'Easy';

  @override
  String get normal => 'Normal';

  @override
  String get advanced => 'Advanced';

  @override
  String get expert => 'Expert';

  @override
  String get victoryDialogTitle => 'You won';

  @override
  String get victoryDialogDismiss => 'Okay';

  @override
  String get settings => 'Settings';

  @override
  String get changedDifficultyDialogTitle => 'Start new game';

  @override
  String get changedDifficultyDialogBody =>
      'The difficulty has been changed. Do you want to start a new game or resume to your current game?';

  @override
  String get changedDifficultyDialogResume => 'Resume game';

  @override
  String get changedDifficultyDialogNew => 'New game';

  @override
  String get osl => 'Open Source Licenses';

  @override
  String appVersion(String version) {
    return 'Version $version';
  }

  @override
  String get sourceCode => 'Source Code';

  @override
  String get theme => 'Appearance';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get leaderboardPageErrorMessage =>
      'An unexpected error occured. Please try again.';

  @override
  String get leaderboardPageErrorButton => 'Reload leaderboard';

  @override
  String get homePageTitle => 'Sudoku';

  @override
  String get homePageSubtitle => 'Challenge your mind with every grid';

  @override
  String get playButton => 'Play';
}
