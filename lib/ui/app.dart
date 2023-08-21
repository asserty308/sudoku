import 'package:flutter/material.dart';
import 'package:sudoku/router/app_router.dart';
import 'package:sudoku/styles/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: appTheme,
    routerConfig: appRouter,
  );
}
