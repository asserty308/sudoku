import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    _difficulty = sudokuRepo.getDifficulty();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: ListView(
      children: [
        _difficultyTile
      ],
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

  void _changeDifficulty(Difficulty? difficulty) {
    if (difficulty == null) {
      return;
    }

    sudokuRepo.setDifficulty(difficulty).then((value) => setState(() {
      _difficulty = sudokuRepo.getDifficulty();
    }));
  }
}