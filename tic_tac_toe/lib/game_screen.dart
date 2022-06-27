import 'package:flutter/material.dart';

import 'methods/game_logic.dart';
import 'ui/theme/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreboard = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ]; //the score are for the different combination of the game [Row1,2,3,Col1,2,3,Diag1,Diag2]

  Game game = Game();

  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Its ${lastValue} turn".toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 58,
                )),
            const SizedBox(height: 20),
            SizedBox(
              width: boardWidth,
              height: boardWidth,
              child: GridView.count(

                  /// the [~/] operator allows you to divide to integer and return an [Int] as a result
                  crossAxisCount: Game.boardLength ~/ 3,
                  padding: const EdgeInsets.all(16.0),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: List.generate(Game.boardLength, (index) {
                    return InkWell(
                      onTap: gameOver
                          ? null
                          : () {
                              // When we clean we nedd to add th new value to board and refresh the screen
                              //we need to also to toggle the player
                              // now we need to apply the click only if the field is empty
                              // now lets create a button to reset the game
                              if (game.board![index] == "") {
                                game.board![index] = lastValue;
                                setState(() {
                                  game.board![index] = lastValue;
                                  turn++;
                                  gameOver = game.winnerCheck(
                                      lastValue, index, scoreboard, 3);
                                  if (gameOver) {
                                    result = "$lastValue wins";
                                  } else if (!gameOver && turn == 9) {
                                    result = "Draw";
                                  }
                                  // } else {
                                  //   lastValue = lastValue == "X" ? "O" : "X";
                                  // }
                                  if (lastValue == 'X') {
                                    lastValue = "O";
                                  } else {
                                    lastValue = "X";
                                  }
                                });
                              }
                            },
                      child: Container(
                        height: Game.blocSize,
                        width: Game.blocSize,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Center(
                          child: Text(
                            game.board![index],
                            style: TextStyle(
                              color: game.board![index] == "X"
                                  ? Colors.blue
                                  : Colors.pink,
                              fontSize: 64.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              result,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 54,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  game.board = Game.initGameBoard();
                  lastValue = "X";
                  gameOver = false;
                  turn = 0;
                  result = "";
                  scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
              icon: const Icon(Icons.replay),
              label: const Text("Repeat the Game"),
            )
          ]),
    );
  }
}
