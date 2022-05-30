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
    return SizedBox(
      height: size.height * 0.10,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResetButton(reset: reset),
            Move(move: move),
            Time(secondsPassed: secondsPassed),
          ]),
    );
  }
}
