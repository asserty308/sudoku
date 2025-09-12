import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/core/config/setup.dart';
import 'package:sudoku/core/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupApp();

  runApp(const ProviderScope(child: MyApp()));
}
