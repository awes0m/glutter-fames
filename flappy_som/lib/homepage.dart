import 'dart:async';
import 'dart:math';

import 'package:flappy_som/models/barriers.dart';
import 'package:flappy_som/models/bird.dart';
import 'package:flappy_som/utils/textstyles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bird Variables
  static double birdY = 0;
  double initialPos = birdY;
  static double birdWidth = 0.2;
  static double birdHeight = 0.2;

  //Physics Variables
  double height = 0;
  double time = 0;
  double velocity = .3; // How strong the Jump is
  double gravity = -4.9; // How Strong the gravity is

  // Game Variables
  bool gameStarted = false;
  int score = 0;
  int highScore = 0;

  // Barrier Variables
  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  static List<List<double>> barrierHeight = [
    [0.4, 0.3],
    [0.3, 0.5],
  ];

  void startgame() {
    gameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // a real physical jump is same as  an upside down parabola
      // y = -4.9x^2 + 5x + 0.5- So this is a simple quadratic eaquation
      height = (gravity * time * time) + (velocity * time);
      setState(() {
        birdY = initialPos - height;
      });

      // Check if the bird has hit the ground
      if (birdIsDead()) {
        timer.cancel();
        gameStarted = false;
        _showDialog();
      }
      //Keep the Map Moving
      moveMap();
      //Keep the clock ticking
      time += 0.1;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      barrierX[i] -= 0.1;
      if (barrierX[i] < -1) {
        barrierX[i] = 2;
        barrierHeight[i] = [
          randomBetween(0.6, 0.8),
          randomBetween(0.6, 0.8),
        ];
      }
    }
  }

  /// [_showDialog] shows a Dialog Box when the game is over
  ///  -also updates the high score if the current score is higher
  ///  -also shows the current score
  /// - also has a button to restart the game [resetGame]
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: const Text(
            'Game Over',
            style: TextStyle(color: Colors.white),
          ),
          content: Text('Your Score is ${score.toString()}',
              style: const TextStyle(color: Colors.white)),
          actions: <Widget>[
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  color: Colors.green,
                  child: const Text(
                    'Play Again',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  /// [resetGame] resets the game to its initial state
  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0.0;
      gameStarted = false;
      time = 0;
      score = 0;
      initialPos = birdY;
    });
  }

  ///[jump] resets the bird to its initial position
  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
      moveMap();
    });
  }

  /// [birdIsDead] checks if the bird has hit the ground or sky
  static bool birdIsDead() {
    // Check if the bird has hit the ground or sky
    if (birdY < -1 || birdY > 1) {
      return true;
    }
    // Check if the bird has hit the barrier
    for (int i = 0; i < barrierX.length; i = i + 1) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameStarted ? jump : startgame,
      child: Scaffold(
        body: Column(
          children: [
            //Upper Game screen
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      //bird
                      MyBird(
                        birdY: birdY,
                        birdHeight: birdHeight,
                        birdWidth: birdWidth,
                      ),
                      // TAP to play text
                      Container(
                        alignment: const Alignment(0, -0.3),
                        child: Text(
                          gameStarted ? '' : "T A P  T O  P L A Y ",
                          style: AppTextStyle.mediumText(Colors.black),
                        ),
                      ),
                      //4 barriers
                      // Top Barrier 0
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierHeight: barrierHeight[0][0],
                        barrierWidth: barrierWidth,
                        isThisBottomBarrier: false,
                      ),
                      // Bottom Barrier 0
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierHeight: barrierHeight[0][1],
                        barrierWidth: barrierWidth,
                        isThisBottomBarrier: true,
                      ),
                      // Top Barrier 1
                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierHeight: barrierHeight[1][0],
                        barrierWidth: barrierWidth,
                        isThisBottomBarrier: false,
                      ),
                      // Bottom Barrier 1
                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierHeight: barrierHeight[1][1],
                        barrierWidth: barrierWidth,
                        isThisBottomBarrier: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Lower Game screen green bar
            Container(height: 15, color: Colors.green[400]),
            //Score section
            Expanded(
              child: Container(
                color: Colors.brown[400],
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Score
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('SCORE',
                              style: AppTextStyle.mediumText(Colors.white)),
                          const SizedBox(height: 20),
                          Text(score.toString(),
                              style: AppTextStyle.bigText(Colors.white)),
                        ],
                      ),
                      //High Score
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('BEST',
                              style: AppTextStyle.mediumText(Colors.white)),
                          const SizedBox(height: 20),
                          Text(highScore.toString(),
                              style: AppTextStyle.bigText(Colors.white)),
                        ],
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

double randomBetween(double d, double e) {
  return d + (e - d) * Random().nextDouble();
}
