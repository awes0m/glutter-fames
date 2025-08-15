import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final double birdY;
  final double birdWidth;
  final double birdHeight;
  const MyBird(
      {super.key,
      required this.birdY,
      required this.birdHeight,
      required this.birdWidth});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final alignY = (2 * birdY + birdHeight) / (2 - birdHeight);
    final imgWidth = screen.width * (birdWidth / 2);
    final imgHeight = (screen.height * 0.75) * (birdHeight / 2);
    return Container(
      alignment: Alignment(0, alignY.clamp(-1.0, 1.0)),
      child: Image.asset(
        'assets/flappy.png',
        fit: BoxFit.contain,
        width: imgWidth,
        height: imgHeight,
      ),
    );
  }
}
