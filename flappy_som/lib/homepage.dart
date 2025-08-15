import 'package:flappy_som/controllers/game_controller.dart';
import 'package:flappy_som/models/barriers.dart';
import 'package:flappy_som/models/bird.dart';
import 'package:flappy_som/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final GameController controller;

  @override
  void initState() {
    super.initState();
    controller = GameController();
    controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (controller.isGameOver) {
      _showGameOver();
    }
    setState(() {});
  }

  void _showGameOver() async {
    await Future.delayed(const Duration(milliseconds: 50));
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.brown,
        title: const Text('Game Over', style: TextStyle(color: Colors.white)),
        content: Text('Your Score is ${controller.score}',
            style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.resetGame();
            },
            child:
                const Text('Play Again', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final rot = ((c.velocity - 1.5) / 4).clamp(-1.0, 1.0) * 0.8;
    return GestureDetector(
      onTap: () {
        if (c.gameStarted) {
          c.jump();
        } else {
          c.startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      Transform.rotate(
                        angle: rot,
                        child: MyBird(
                            birdY: c.birdY,
                            birdHeight: c.birdHeight,
                            birdWidth: c.birdWidth),
                      ),
                      Container(
                        alignment: const Alignment(0, -0.3),
                        child: Text(c.gameStarted ? '' : "T A P  T O  P L A Y ",
                            style: AppTextStyle.mediumText(Colors.black)),
                      ),
                      MyBarrier(
                          barrierX: c.barrierX[0],
                          barrierHeight: c.barrierHeight[0][0],
                          barrierWidth: c.barrierWidth,
                          isThisBottomBarrier: false),
                      MyBarrier(
                          barrierX: c.barrierX[0],
                          barrierHeight: c.barrierHeight[0][1],
                          barrierWidth: c.barrierWidth,
                          isThisBottomBarrier: true),
                      MyBarrier(
                          barrierX: c.barrierX[1],
                          barrierHeight: c.barrierHeight[1][0],
                          barrierWidth: c.barrierWidth,
                          isThisBottomBarrier: false),
                      MyBarrier(
                          barrierX: c.barrierX[1],
                          barrierHeight: c.barrierHeight[1][1],
                          barrierWidth: c.barrierWidth,
                          isThisBottomBarrier: true),
                    ],
                  ),
                ),
              ),
            ),
            Container(height: 15, color: Colors.green[400]),
            Expanded(
              child: Container(
                color: Colors.brown[400],
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('SCORE',
                                  style: AppTextStyle.mediumText(Colors.white)),
                              const SizedBox(height: 20),
                              Text(c.score.toString(),
                                  style: AppTextStyle.bigText(Colors.white)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('BEST',
                                  style: AppTextStyle.mediumText(Colors.white)),
                              const SizedBox(height: 20),
                              Text(c.highScore.toString(),
                                  style: AppTextStyle.bigText(Colors.white)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Difficulty',
                                    style:
                                        AppTextStyle.mediumText(Colors.white)),
                                Text(c.difficulty.toStringAsFixed(1),
                                    style:
                                        AppTextStyle.mediumText(Colors.white)),
                              ],
                            ),
                            Slider(
                              min: 0.5,
                              max: 2.0,
                              divisions: 15,
                              value: c.difficulty.clamp(0.5, 2.0),
                              label: c.difficulty.toStringAsFixed(1),
                              onChanged: (v) => setState(() {
                                controller.setDifficulty(v);
                              }),
                            ),
                            const SizedBox(height: 8),
                            // Preset buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _presetButton('Easy', 0.7, c.difficulty),
                                _presetButton('Normal', 1.0, c.difficulty),
                                _presetButton('Hard', 1.6, c.difficulty),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Web tuning',
                                    style:
                                        AppTextStyle.mediumText(Colors.white)),
                                Row(
                                  children: [
                                    Text(kIsWeb ? 'Auto (Web)' : 'Auto',
                                        style: AppTextStyle.mediumText(
                                            Colors.white)),
                                    Switch(
                                      value: c.useWebTuning,
                                      onChanged: (v) => setState(() {
                                        controller.setUseWebTuning(v);
                                      }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _presetButton(String label, double value, double current) {
    final active = (current - value).abs() < 0.05;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: active ? Colors.orange : Colors.white24,
        foregroundColor: active ? Colors.white : Colors.white,
      ),
      onPressed: () {
        setState(() {
          controller.setDifficulty(value);
        });
      },
      child: Text(label),
    );
  }
}
