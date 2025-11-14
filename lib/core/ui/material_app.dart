import 'package:flutter/material.dart';
import 'package:sudoku/core/theme/theme.dart';
import 'package:sudoku/l10n/gen/app_localizations.dart';
import 'package:sudoku/l10n/l10n.dart';

class SudokuMaterialApp extends StatelessWidget {
  const SudokuMaterialApp({super.key, required this.routerConfig});

  final RouterConfig<Object> routerConfig;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    restorationScopeId: 'app',
    onGenerateTitle: (context) => context.l10n.appTitle,
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    darkTheme: darkTheme,
    routerConfig: routerConfig,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
