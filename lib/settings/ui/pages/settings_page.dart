import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/app/config/app_config.dart';
import 'package:sudoku/game/data/providers/providers.dart';
import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/app/domain/setup.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/settings/data/providers/providers.dart';
import 'package:sudoku/settings/ui/blocs/difficulty/difficulty_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  late final _settingsController = ref.read(settingsControllerProvider);
  late final _gameBloc = ref.read(sudokuCubitProvider);

  late final _difficultyBloc = DifficultyCubit(
    getDifficultyUseCase: ref.read(getDifficultyUseCaseProvider),
    setDifficultyUseCase: ref.read(setDifficultyUseCaseProvider),
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _settingsController.loadSettings();
      _difficultyBloc.getDifficulty();
    });
  }

  // TODO: PopScope not working with go_router https://github.com/flutter/flutter/issues/138737
  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      if (_difficultyBloc.difficultyChanged) {
        await _showDifficultyChangedDialog();
      }
      return true;
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: ListView(
        children: [
          _difficultyTile,
          _themeTile,
          const SizedBox(
            height: 16,
          ),
          _licensesTile(context),
          _showGitHubRepoTile(context),
          _versionTileBuilder(context),
        ],
      ),
    ),
  );

  Widget get _difficultyTile => BlocBuilder<DifficultyCubit, DifficultyState>(
    bloc: _difficultyBloc,
    builder: (context, state) => ListTile(
      title: Text(context.l10n.difficulty),
      trailing: DropdownButton<Difficulty>(
        value: _difficultyBloc.difficulty,
        items: DifficultyExt.playable
          .map((element) => DropdownMenuItem<Difficulty>(
            value: element,
            child: Text(element.title(context)),
          ))
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
            )
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
      onTap: () => launchUrl(Uri.parse(gitHubRepoUrl)));

  Widget _versionTileBuilder(BuildContext context) => ListTile(
        subtitle: Text(context.l10n.appVersion(appPackageInfo.version)),
      );

  Future<void> _showDifficultyChangedDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.changedDifficultyDialogTitle),
        content: Text(context.l10n.changedDifficultyDialogBody),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
              _gameBloc.buildNewGame();
            },
            child: Text(context.l10n.changedDifficultyDialogNew),
          ),
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(context.l10n.changedDifficultyDialogResume),
          ),
        ],
      ),
    );
  }

  void _changeDifficulty(Difficulty? difficulty) {
    if (difficulty == null) {
      return;
    }

    _difficultyBloc.changeDifficulty(difficulty);
  }
}
