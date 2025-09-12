import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/core/config/app_router.dart';
import 'package:sudoku/core/theme/theme.dart';
import 'package:sudoku/features/settings/data/providers/providers.dart';
import 'package:sudoku/l10n/gen/app_localizations.dart';
import 'package:sudoku/l10n/l10n.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final _settingsController = ref.read(settingsControllerProvider);
  late final _appRouter = ref.read(appRouterProvider);

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _settingsController,
    builder: (context, child) => _app,
  );

  Widget get _app => MaterialApp.router(
    title: context.l10n.appTitle,
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: _settingsController.themeMode,
    routerConfig: _appRouter,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
