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
      items: [
        DropdownMenuItem<Difficulty>(
          value: Difficulty.beginner,
          child: Text(context.l10n.beginner)
        ),
        DropdownMenuItem<Difficulty>(
          value: Difficulty.easy,
          child: Text(context.l10n.easy)
        ),
        DropdownMenuItem<Difficulty>(
          value: Difficulty.normal,
          child: Text(context.l10n.normal)
        ),
        DropdownMenuItem<Difficulty>(
          value: Difficulty.advanced,
          child: Text(context.l10n.advanced)
        ),
        DropdownMenuItem<Difficulty>(
          value: Difficulty.expert,
          child: Text(context.l10n.expert)
        ),
      ],
      onChanged: (value) {
        if (value == null) {
          return;
        }

        sudokuRepo.setDifficulty(value).then((value) => setState(() {
          _difficulty = sudokuRepo.getDifficulty();
        }));
      },
    ),
  );
}