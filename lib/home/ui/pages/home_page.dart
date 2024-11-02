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

  Widget get _body => ListView(
    physics: ClampingScrollPhysics(),
    children: [
      _title,
      _playButton,
    ],
  );

  Widget get _title => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Sudoku', style: Theme.of(context).textTheme.headlineMedium,),
      Text('Challenge your mind with every grid.'),
    ],
  );

  Widget get _playButton => TextButton(
    onPressed: () => context.go('/play'), 
    style: TextButton.styleFrom(
      shape: StadiumBorder(),
      backgroundColor: Colors.blueGrey[400],
    ),
    child: Text('Play'),
  );
}
