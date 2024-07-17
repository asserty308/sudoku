import 'package:flutter/material.dart';
import 'package:sudoku/app/domain/app_session.dart';
import 'package:sudoku/app/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupApp();

  runApp(const MyApp());
}
