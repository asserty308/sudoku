import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/app/config/app_config.dart';
import 'package:sudoku/app/data/services/web_lifecycle_service.dart';
import 'package:sudoku/app/domain/app_router.dart';
import 'package:sudoku/app/ui/styles/theme.dart';
import 'package:sudoku/l10n/gen/app_localizations.dart';
import 'package:sudoku/settings/data/providers/providers.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  late final _settingsController = ref.read(settingsControllerProvider);
  late final _appRouter = ref.read(appRouterProvider);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _settingsController.loadSettings();
    
    // Initialize web lifecycle service for better web support
    if (kIsWeb) {
      WebLifecycleService.instance.initialize();
      
      // Listen to visibility changes
      WebLifecycleService.instance.onVisibilityChanged.listen((isVisible) {
        if (isVisible) {
          // Page became visible - reload settings to ensure consistency
          _settingsController.loadSettings();
        }
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (kIsWeb) {
      WebLifecycleService.instance.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // Handle app lifecycle changes
    switch (state) {
      case AppLifecycleState.resumed:
        // App became active again - ensure settings are loaded
        _settingsController.loadSettings();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // App going to background - state is already persisted via SharedPreferences
        break;
    }
  }

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
    routerConfig: _appRouter,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
