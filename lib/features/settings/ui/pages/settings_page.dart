import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/core/config/constants.dart';
import 'package:sudoku/core/config/setup.dart';
import 'package:sudoku/features/game/data/models/difficulty.dart';
import 'package:sudoku/features/game/data/providers/providers.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/features/settings/data/providers/providers.dart';
import 'package:sudoku/features/settings/ui/blocs/difficulty/difficulty_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends AppConsumerState<SettingsPage> {
  late final _settingsController = ref.read(settingsControllerProvider);

  late final _difficultyBloc = DifficultyCubit(
    getDifficultyUseCase: ref.read(getDifficultyUseCaseProvider),
    setDifficultyUseCase: ref.read(setDifficultyUseCaseProvider),
  );

  Difficulty? newDifficulty;

  @override
  void onUIReady() {
    super.onUIReady();

    _settingsController.loadSettings();
    _difficultyBloc.getDifficulty();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(context.l10n.settings),
      leading: IconButton(
        onPressed: () => context.pop<Difficulty>(newDifficulty),
        icon: Icon(Icons.arrow_back),
      ),
    ),
    body: ListView(
      children: [
        _difficultyTile,
        _themeTile,
        vGap16,
        _licensesTile(context),
        _showGitHubRepoTile(context),
        _versionTileBuilder(context),
      ],
    ),
  );

  Widget get _difficultyTile => BlocConsumer<DifficultyCubit, DifficultyState>(
    bloc: _difficultyBloc,
    listener: (context, state) {
      if (state is DifficultyChanged) {
        setState(() {
          newDifficulty = state.difficulty;
        });
      }
    },
    builder: (context, state) => ListTile(
      title: Text(context.l10n.difficulty),
      trailing: DropdownButton<Difficulty>(
        value: _difficultyBloc.difficulty,
        items: DifficultyExt.playable
            .map(
              (element) => DropdownMenuItem<Difficulty>(
                value: element,
                child: Text(element.title(context)),
              ),
            )
            .toList(),
        onChanged: _changeDifficulty,
      ),
    ),
  );

  Widget get _themeTile => ListTile(
    title: Text(context.l10n.theme),
    trailing: DropdownButton<ThemeMode>(
      // Read the selected themeMode from the controller
      value: _settingsController.themeMode,
      // Call the updateThemeMode method any time the user selects a theme.
      onChanged: (theme) => _settingsController
          .updateThemeMode(theme)
          .then((value) => setState(() {})),
      items: [
        DropdownMenuItem(
          value: ThemeMode.system,
          child: Text(context.l10n.systemTheme),
        ),
        DropdownMenuItem(
          value: ThemeMode.light,
          child: Text(context.l10n.lightTheme),
        ),
        DropdownMenuItem(
          value: ThemeMode.dark,
          child: Text(context.l10n.darkTheme),
        ),
      ],
    ),
  );

  Widget _licensesTile(BuildContext context) => ListTile(
    title: Text(context.l10n.osl),
    onTap: () => showLicensePage(
      context: context,
      applicationVersion: appPackageInfo.version,
    ),
  );

  Widget _showGitHubRepoTile(BuildContext context) => ListTile(
    title: Text(context.l10n.sourceCode),
    onTap: () => launchUrl(Uri.parse(gitHubRepoUrl)),
  );

  Widget _versionTileBuilder(BuildContext context) =>
      ListTile(subtitle: Text(context.l10n.appVersion(appPackageInfo.version)));

  void _changeDifficulty(Difficulty? difficulty) {
    if (difficulty == null) {
      return;
    }

    _difficultyBloc.changeDifficulty(difficulty);
  }
}
