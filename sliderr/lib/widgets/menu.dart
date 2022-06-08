import 'package:flutter/material.dart';
import 'package:sliding_puzzle/utils/theme_model.dart';

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
            color: Theme.of(context).shadowColor,
            offset: const Offset(2, 2),
            blurRadius: 10,
            spreadRadius: -5,
          ),
          BoxShadow(
            color: isDark(context) ? Colors.white54 : Colors.black54,
            offset: const Offset(-2, -2),
            blurRadius: 10,
            spreadRadius: -5,
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
              const Divider(thickness: 0),
              Move(move: move),
              const Divider(thickness: 0),
              Time(secondsPassed: secondsPassed),
            ]),
      ),
    );
  }
}
