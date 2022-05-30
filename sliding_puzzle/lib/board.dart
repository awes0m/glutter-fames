import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sliding_puzzle/widgets/drawer.dart';
import 'package:sliding_puzzle/widgets/mytitle.dart';

import 'widgets/grid.dart';
import 'widgets/menu.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int move = 0;
  int secondsPassed = 0;

  ///Timer for the game
  Timer? timer;

  ///Whether the game is running or not
  bool isActive = false;

  @override
  void initState() {
    numbers.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    timer ??= Timer.periodic(const Duration(seconds: 1), (Timer t) {
      startTime();
    });
    return SafeArea(
        child: Scaffold(
      appBar: MyTitle(size: size),
      drawer: drawer(context),
      body: Container(
        height: size.height,
        color: Colors.blueGrey,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.02,
            ),
            Grid(
              numbers: numbers,
              size: size,
              clickGrid: (index) => clickGrid(index),
            ),
            Menu(
              reset: reset,
              move: move,
              secondsPassed: secondsPassed,
              size: size,
            ),
          ],
        ),
      ),
    ));
  }

  void clickGrid(index) {
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == 0) ||
        (index + 4 < 16 && numbers[index + 4] == 0)) {
      setState(() {
        move += 1;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
      });
    }
    checkWin();
  }

  void reset() {
    setState(() {
      numbers.shuffle();
      move = 0;
      secondsPassed = 0;
      isActive = false;
    });
  }

  void startTime() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  bool isSorted(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i += 1) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(numbers)) {
      isActive = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "You Win!!",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 220.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: const Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
