import 'package:flutter/material.dart';
import 'package:sudoku/app/services/app_session.dart';
import 'package:sudoku/app/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupSession();

  runApp(const MyApp());
}
