class SudokuModel({required final List<List<int>> board, required final List<List<int>> solution}) {
  List<List<int>> get boardCopy => board.map((row) => [...row]).toList();
}
