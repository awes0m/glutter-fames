import 'package:flutter/material.dart';

class Move extends StatelessWidget {
  final int move;
  const Move({Key? key, required this.move}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text("Move: $move",
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.none)),
    );
  }
}
