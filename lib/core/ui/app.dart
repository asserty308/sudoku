import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sudoku/core/navigation/router.dart';
import 'package:sudoku/core/theme/theme.dart';
import 'package:sudoku/l10n/gen/app_localizations.dart';
import 'package:sudoku/l10n/l10n.dart';

class const MyApp({super.key}) extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState() extends AppConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    restorationScopeId: 'app',
    onGenerateTitle: (context) => context.l10n.appTitle,
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    darkTheme: darkTheme,
    routerConfig: ref.read(goRouterProvider),
    localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        ...GlobalMaterialLocalizations.delegates,
      ],
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
