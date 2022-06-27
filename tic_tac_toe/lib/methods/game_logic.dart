class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static final boardLength = 9;
  static final blocSize = 100.0;

  List<String>? board;

  static List<String>? initGameBoard() =>
      List.generate(boardLength, (i) => Player.empty);

      // Win check Algoirthm
      // for this we need first to declare a scoreboard in our main file
  bool winnerCheck(String player, int index, List<int> scoreboard,int gridsize){
    //first lets declare a row and column
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == "X"?1:-1;

    scoreboard[row] += score;
    scoreboard[gridsize + col] += score;
    if (row == col)scoreboard[gridsize * 2] += score;
    if(gridsize -1 -col ==row)scoreboard[2*gridsize+1] += score;

    // checking if we have 3 or -3 in th score board
    if(scoreboard.contains(3)|| scoreboard.contains(-3)){
      return true;
    }
    //by default we return false
    return false;
  }
}
