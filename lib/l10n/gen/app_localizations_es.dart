// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Sudoku';

  @override
  String get difficulty => 'Dificultad';

  @override
  String get test => 'Prueba';

  @override
  String get beginner => 'Principiante';

  @override
  String get easy => 'Fácil';

  @override
  String get normal => 'Normal';

  @override
  String get advanced => 'Avanzado';

  @override
  String get expert => 'Experto';

  @override
  String get victoryDialogTitle => 'Has ganado';

  @override
  String get victoryDialogDismiss => 'Vale';

  @override
  String get settings => 'Configuración';

  @override
  String get changedDifficultyDialogTitle => 'Nuevo juego';

  @override
  String get changedDifficultyDialogBody =>
      'La dificultad ha sido cambiada. ¿Quieres empezar un nuevo juego o continuar con el actual?';

  @override
  String get changedDifficultyDialogResume => 'Continuar juego';

  @override
  String get changedDifficultyDialogNew => 'Nuevo juego';

  @override
  String get osl => 'Licencias Open Source';

  @override
  String appVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get sourceCode => 'Código fuente';

  @override
  String get theme => 'Apariencia';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get lightTheme => 'Claro';

  @override
  String get darkTheme => 'Oscuro';

  @override
  String get leaderboardPageTitle => 'Clasificación';

  @override
  String get leaderboardPageErrorMessage =>
      'Ha ocurrido un error inesperado. Por favor, inténtalo de nuevo.';

  @override
  String get leaderboardPageErrorButton => 'Recargar clasificación';

  @override
  String get leaderboardPageNetworkError =>
      'No se puede conectar a internet. Por favor, verifica tu conexión e inténtalo de nuevo.';

  @override
  String get leaderboardPageStorageError =>
      'No se puede acceder a los datos guardados. Por favor, reinicia la aplicación e inténtalo de nuevo.';

  @override
  String get leaderboardPageUnknownError =>
      'Algo salió mal. Por favor, inténtalo más tarde.';

  @override
  String get leaderboardPageRetryButton => 'Reintentar';

  @override
  String get leaderboardPageRefreshTooltip =>
      'Desliza hacia abajo para actualizar';

  @override
  String get leaderboardPageEmpty => 'No hay entradas disponibles';

  @override
  String get leaderboardPageEmptyTitle => 'Aún no hay clasificación';

  @override
  String get leaderboardPageEmptyDescription =>
      '¡Completa un juego para ver tu tiempo en la clasificación!';

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
  String get homePageSubtitle => 'Desafía tu mente con cada cuadrícula';

  @override
  String get playButton => 'Jugar';

  @override
  String get enterYourNameDialogTitle => 'Introduce tu nombre';

  @override
  String get enterYourNameHint => 'Tu nombre';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get submitButton => 'Enviar';

  @override
  String get connectionErrorTitle => 'Error de conexión';

  @override
  String get storageErrorTitle => 'Error de almacenamiento';

  @override
  String get unexpectedErrorTitle => 'Error inesperado';
}
