import 'package:flutter/material.dart';
import 'package:sliding_puzzle/utils/constants.dart';

class Move extends StatelessWidget {
  final int move;
  const Move({Key? key, required this.move}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Move: $move", style: normalText(context, getSize(context))),
    );
  }
}
