import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

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
  Timer? _timer;

  @override
  void onUIReady() {
    super.onUIReady();

    _setupTimer();
  }

  @override
  void didUpdateWidget(SudokuTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If startTime changed, restart the timer
    if (oldWidget.startTime != widget.startTime) {
      _timer?.cancel();
      _setupTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Text(_duration.formatMS(trailing: 'm'));

  void _setupTimer() {
    // Reset duration to zero for new timer
    _duration = Duration.zero;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _duration = DateTime.now().difference(widget.startTime);
      });
    });

    widget.onTimerCreated(_timer!);
  }
}
