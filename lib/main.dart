import 'package:flutter/material.dart';
import 'package:sudoku/data/services/app_session.dart';
import 'package:sudoku/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupSession();

  runApp(const MyApp());
}
