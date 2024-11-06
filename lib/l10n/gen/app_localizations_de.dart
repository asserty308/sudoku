import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get difficulty => 'Schwierigkeitsgrad';

  @override
  String get test => 'Test';

  @override
  String get beginner => 'Anfänger';

  @override
  String get easy => 'Einfach';

  @override
  String get normal => 'Normal';

  @override
  String get advanced => 'Fortgeschritten';

  @override
  String get expert => 'Experte';

  @override
  String get victoryDialogTitle => 'Du hast gewonnen';

  @override
  String get victoryDialogDismiss => 'Okay';

  @override
  String get settings => 'Einstellungen';

  @override
  String get changedDifficultyDialogTitle => 'Neues Spiel';

  @override
  String get changedDifficultyDialogBody => 'Der Schwierigkeitsgrad wurde geändert. Möchtest du ein neues Spiel starten oder zu deinem aktuellen zurückkehren?';

  @override
  String get changedDifficultyDialogResume => 'Zurück zum Spiel';

  @override
  String get changedDifficultyDialogNew => 'Neues Spiel';

  @override
  String get osl => 'Open Source Lizenzen';

  @override
  String appVersion(String version) {
    return 'Version $version';
  }

  @override
  String get sourceCode => 'Quellcode';

  @override
  String get theme => 'Darstellung';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Hell';

  @override
  String get darkTheme => 'Dunkel';

  @override
  String get leaderboardPageErrorMessage => 'Ein Fehler ist aufgetreten. Bitte versuche es erneut.';

  @override
  String get leaderboardPageErrorButton => 'Erneut laden';
}
