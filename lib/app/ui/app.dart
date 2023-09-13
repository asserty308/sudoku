import 'package:flutter/material.dart';
import 'package:sudoku/app/config/app_config.dart';
import 'package:sudoku/app/router/app_router.dart';
import 'package:sudoku/app/styles/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sudoku/settings/services/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: settingsController, 
    builder: (context, child) => _app,
  );
  
  Widget get _app => MaterialApp.router(
    title: appName,
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: settingsController.themeMode,
    routerConfig: appRouter,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
