import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @difficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficulty;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// No description provided for @beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// No description provided for @easy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @expert.
  ///
  /// In en, this message translates to:
  /// **'Expert'**
  String get expert;

  /// No description provided for @victoryDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'You won'**
  String get victoryDialogTitle;

  /// No description provided for @victoryDialogDismiss.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get victoryDialogDismiss;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @changedDifficultyDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Start new game'**
  String get changedDifficultyDialogTitle;

  /// No description provided for @changedDifficultyDialogBody.
  ///
  /// In en, this message translates to:
  /// **'The difficulty has been changed. Do you want to start a new game or resume to your current game?'**
  String get changedDifficultyDialogBody;

  /// No description provided for @changedDifficultyDialogResume.
  ///
  /// In en, this message translates to:
  /// **'Resume game'**
  String get changedDifficultyDialogResume;

  /// No description provided for @changedDifficultyDialogNew.
  ///
  /// In en, this message translates to:
  /// **'New game'**
  String get changedDifficultyDialogNew;

  /// No description provided for @osl.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get osl;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String appVersion(String version);

  /// No description provided for @sourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceCode;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get theme;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @leaderboardPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboardPageTitle;

  /// No description provided for @leaderboardPageErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occured. Please try again.'**
  String get leaderboardPageErrorMessage;

  /// No description provided for @leaderboardPageErrorButton.
  ///
  /// In en, this message translates to:
  /// **'Reload leaderboard'**
  String get leaderboardPageErrorButton;

  /// No description provided for @leaderboardPageNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to the internet. Please check your connection and try again.'**
  String get leaderboardPageNetworkError;

  /// No description provided for @leaderboardPageStorageError.
  ///
  /// In en, this message translates to:
  /// **'Unable to access saved data. Please restart the app and try again.'**
  String get leaderboardPageStorageError;

  /// No description provided for @leaderboardPageUnknownError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again later.'**
  String get leaderboardPageUnknownError;

  /// No description provided for @leaderboardPageRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get leaderboardPageRetryButton;

  /// No description provided for @leaderboardPageRefreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Pull down to refresh'**
  String get leaderboardPageRefreshTooltip;

  /// No description provided for @leaderboardPageEmpty.
  ///
  /// In en, this message translates to:
  /// **'No entries available'**
  String get leaderboardPageEmpty;

  /// No description provided for @leaderboardPageEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Leaderboard Yet'**
  String get leaderboardPageEmptyTitle;

  /// No description provided for @leaderboardPageEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete a game to see your time on the leaderboard!'**
  String get leaderboardPageEmptyDescription;

  /// No description provided for @leaderboardPageRankingFormat.
  ///
  /// In en, this message translates to:
  /// **'{rank}.'**
  String leaderboardPageRankingFormat(int rank);

  /// No description provided for @leaderboardPageTimeFormat.
  ///
  /// In en, this message translates to:
  /// **'{time} min'**
  String leaderboardPageTimeFormat(String time);

  /// No description provided for @homePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Sudoku'**
  String get homePageTitle;

  /// No description provided for @homePageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Challenge your mind with every grid'**
  String get homePageSubtitle;

  /// No description provided for @playButton.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get playButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
