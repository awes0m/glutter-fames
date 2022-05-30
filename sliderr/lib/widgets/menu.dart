import 'package:flutter/material.dart';

import '../utils/constants.dart';
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
      height: kIsWeb ? size.height * 0.15 : size.height * 0.10,
      width: kIsWeb ? double.infinity : size.width * 0.93,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.5),
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ResetButton(reset: reset),
              const Divider(color: Colors.black54, thickness: 0),
              Move(move: move),
              const Divider(color: Colors.black54, thickness: 0),
              Time(secondsPassed: secondsPassed),
            ]),
      ),
    );
  }
}
