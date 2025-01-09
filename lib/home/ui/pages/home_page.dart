import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      Text('Sudoku', style: Theme.of(context).textTheme.headlineMedium,),
      Text('Challenge your mind with every grid.'),
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
      child: Text('Play'),
    ),
  );
}
