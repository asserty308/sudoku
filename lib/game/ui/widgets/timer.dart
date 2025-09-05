import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sudoku/app/domain/duration.dart';

class SudokuTimer extends StatefulWidget {
  const SudokuTimer({
    super.key,
    required this.startTime,
    required this.onTimerCreated,
  });

  final DateTime startTime;
  final void Function(Timer timer) onTimerCreated;

  @override
  State<SudokuTimer> createState() => _SudokuTimerState();
}

class _SudokuTimerState extends AppState<SudokuTimer> {
  var _duration = Duration.zero;

  @override
  void onUIReady() {
    super.onUIReady();

    _setupTimer();
  }

  @override
  Widget build(BuildContext context) => Text(_duration.format);

  void _setupTimer() {
    final timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _duration = DateTime.now().difference(widget.startTime);
      });
    });

    widget.onTimerCreated(timer);
  }
}
