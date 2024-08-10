import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/app/config/app_config.dart';
import 'package:sudoku/app/domain/app_router.dart';
import 'package:sudoku/app/ui/styles/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sudoku/settings/data/providers/providers.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final _settingsController = ref.read(settingsControllerProvider);

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _settingsController, 
    builder: (context, child) => _app,
  );

  Widget get _app => MaterialApp.router(
    title: appName,
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: _settingsController.themeMode,
    routerConfig: appRouter,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
