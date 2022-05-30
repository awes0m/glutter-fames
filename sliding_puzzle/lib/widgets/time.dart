import 'package:flutter/material.dart';
import 'package:sliding_puzzle/utils/constants.dart';

class Time extends StatelessWidget {
  final int secondsPassed;
  const Time({Key? key, required this.secondsPassed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Time: $secondsPassed",
          style: normalText(context, getSize(context))),
    );
  }
}
