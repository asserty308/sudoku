import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/app/data/providers/providers.dart';
import 'package:sudoku/settings/domain/settings_controller.dart';

final settingsControllerProvider = Provider((ref) => SettingsController(
  sharedPrefs: ref.watch(sharedPrefsProvider),
));
