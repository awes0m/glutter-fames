import 'package:flutter/material.dart';

class Time extends StatelessWidget {
  final int secondsPassed;
  const Time({Key? key, required this.secondsPassed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Time: $secondsPassed",
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            decoration: TextDecoration.none),
      ),
    );
  }
}
