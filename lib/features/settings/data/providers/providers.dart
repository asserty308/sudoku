import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/core/di/providers.dart';
import 'package:sudoku/features/settings/domain/settings_controller.dart';

final settingsControllerProvider = Provider(
  (ref) => SettingsController(sharedPrefs: ref.watch(sharedPrefsProvider)),
);
