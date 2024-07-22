class SudokuModel {
  SudokuModel({required this.board, required this.solution});

  final List<List<int>> board;
  final List<List<int>> solution;

  List<List<int>> get boardCopy => board.map((row) => [...row]).toList();
}
