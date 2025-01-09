import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/l10n/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: _body,
  );

  Widget get _body => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 24,
    children: [
      Text(context.l10n.homePageTitle, style: Theme.of(context).textTheme.headlineMedium,),
      Text(context.l10n.homePageSubtitle),
      _playButton,
    ],
  );

  Widget get _playButton => Center(
    child: TextButton(
      onPressed: () => context.go('/play'), 
      style: TextButton.styleFrom(
        shape: StadiumBorder(),
        backgroundColor: Colors.blueGrey[400],
        minimumSize: Size(200, 50),
      ),
      child: Text(context.l10n.playButton),
    ),
  );
}
