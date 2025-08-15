import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double barrierX;
  final double barrierHeight; // proportion of screen height
  final double barrierWidth; // out of 2 , where 2 is the width of the screen
  final bool isThisBottomBarrier;
  const MyBarrier({
    super.key,
    required this.barrierHeight,
    required this.barrierWidth,
    required this.isThisBottomBarrier,
    required this.barrierX,
  });

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final alignX =
        ((2 * barrierX + barrierWidth) / (2 - barrierWidth)).clamp(-1.0, 1.0);
    final w = (screen.width * barrierWidth / 2).clamp(10.0, screen.width);
    final h =
        (screen.height * 0.75 * barrierHeight / 2).clamp(10.0, screen.height);
    return Container(
      alignment: Alignment(alignX, isThisBottomBarrier ? 1 : -1),
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.green[400],
        ),
      ),
    );
  }
}
