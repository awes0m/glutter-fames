import 'package:flutter/material.dart';

import 'move.dart';
import 'resetbutton.dart';
import 'time.dart';

class Menu extends StatelessWidget {
  final VoidCallback reset;
  final int move;
  final int secondsPassed;
  final Size size;
  const Menu({
    Key? key,
    required this.reset,
    required this.move,
    required this.secondsPassed,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.10,
      width: size.width * 0.95,
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResetButton(reset: reset),
              Divider(color: Colors.white, thickness: 2),
              Move(move: move),
              Divider(color: Colors.white, thickness: 2),
              Time(secondsPassed: secondsPassed),
            ]),
      ),
    );
  }
}
