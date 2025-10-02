import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/core/navigation/router.dart';

final sharedPrefsProvider = Provider((ref) => SharedPreferencesAsync());

final appRouterProvider = Provider((ref) => AppRouter.instance);
