// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Sudoku';

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
  String get changedDifficultyDialogBody =>
      'Der Schwierigkeitsgrad wurde geändert. Möchtest du ein neues Spiel starten oder zu deinem aktuellen zurückkehren?';

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
  String get leaderboardPageTitle => 'Bestenliste';

  @override
  String get leaderboardPageErrorMessage =>
      'Ein Fehler ist aufgetreten. Bitte versuche es erneut.';

  @override
  String get leaderboardPageErrorButton => 'Erneut laden';

  @override
  String get leaderboardPageNetworkError =>
      'Keine Internetverbindung. Bitte überprüfe deine Verbindung und versuche es erneut.';

  @override
  String get leaderboardPageStorageError =>
      'Zugriff auf gespeicherte Daten fehlgeschlagen. Bitte starte die App neu und versuche es erneut.';

  @override
  String get leaderboardPageUnknownError =>
      'Etwas ist schief gelaufen. Bitte versuche es später erneut.';

  @override
  String get leaderboardPageRetryButton => 'Wiederholen';

  @override
  String get leaderboardPageRefreshTooltip =>
      'Nach unten ziehen zum Aktualisieren';

  @override
  String get leaderboardPageEmpty => 'Keine Einträge verfügbar';

  @override
  String get leaderboardPageEmptyTitle => 'Noch keine Bestenliste';

  @override
  String get leaderboardPageEmptyDescription =>
      'Beende ein Spiel, um deine Zeit in der Bestenliste zu sehen!';

  @override
  String leaderboardPageRankingFormat(int rank) {
    return '$rank.';
  }

  @override
  String leaderboardPageTimeFormat(String time) {
    return '$time min';
  }

  @override
  String get homePageTitle => 'Sudoku';

  @override
  String get homePageSubtitle =>
      'Fordere deinen Verstand mit jedem Gitter heraus';

  @override
  String get playButton => 'Spielen';

  @override
  String get enterYourNameDialogTitle => 'Gib deinen Namen ein';

  @override
  String get enterYourNameHint => 'Dein Name';

  @override
  String get cancelButton => 'Abbrechen';

  @override
  String get submitButton => 'Bestätigen';

  @override
  String get connectionErrorTitle => 'Verbindungsfehler';

  @override
  String get storageErrorTitle => 'Speicherfehler';

  @override
  String get unexpectedErrorTitle => 'Unerwarteter Fehler';
}
