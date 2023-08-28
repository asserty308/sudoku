import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/business/sudoku/sudoku_cubit.dart';
import 'package:sudoku/data/models/difficulty.dart';
import 'package:sudoku/data/repositories/sudoku_repo.dart';
import 'package:sudoku/l10n/l10n.dart';

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
      appBar: AppBar(),
      body: ListView(
        children: [
          _difficultyTile,
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