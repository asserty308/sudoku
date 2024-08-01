import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/app/domain/duration.dart';

class SudokuTimer extends StatefulWidget {
  const SudokuTimer({super.key, required this.startTime});

  final DateTime startTime;

  @override
  State<SudokuTimer> createState() => _SudokuTimerState();
}

class _SudokuTimerState extends State<SudokuTimer> {
  var _duration = Duration.zero;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) {
          return;
        }
        
        setState(() {
          _duration += const Duration(seconds: 1);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) => Text(_duration.formatHMS());
}
