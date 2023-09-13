import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/app/config/app_config.dart';
import 'package:sudoku/game/business/sudoku/sudoku_cubit.dart';
import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/game/data/repositories/sudoku_repo.dart';
import 'package:sudoku/app/services/app_session.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/settings/services/settings_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Difficulty _difficulty; 
  var _difficultyChanged = false;

  @override
  void initState() {
    super.initState();

    _difficulty = sudokuRepo.getDifficulty();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      if (_difficultyChanged) {
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
          const SizedBox(height: 16,),
          _licensesTile(context),
          _showGitHubRepoTile(context),
          _versionTileBuilder(context),
        ],
      ),
    ),
  );

  Widget get _difficultyTile => ListTile(
    title: Text(context.l10n.difficulty),
    trailing: DropdownButton<Difficulty>(
      value: _difficulty,
      items: DifficultyExt.playable
        .map((element) => DropdownMenuItem<Difficulty>(
          value: element,
          child: Text(element.title(context)),
        )).toList(),
      onChanged: _changeDifficulty,
    ),
  );

  Widget get _themeTile => ListTile(
    title: Text(context.l10n.theme),
    trailing: DropdownButton<ThemeMode>(
      // Read the selected themeMode from the controller
      value: settingsController.themeMode,
      // Call the updateThemeMode method any time the user selects a theme.
      onChanged: (theme) => settingsController.updateThemeMode(theme).then((value) => setState(() {})),
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
    onTap: () => launchUrl(Uri.parse(gitHubRepoUrl))
  );

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
              sudokuBloc.buildNewGame();
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

    sudokuRepo.setDifficulty(difficulty).then((value) => setState(() {
      _difficulty = sudokuRepo.getDifficulty();
      _difficultyChanged = true;
    }));
  }
}