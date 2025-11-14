import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/core/navigation/router.dart';
import 'package:sudoku/core/ui/material_app.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends AppConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) =>
      SudokuMaterialApp(routerConfig: ref.read(goRouterProvider));
}
