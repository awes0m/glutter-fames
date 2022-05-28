import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double barrierX;
  final double barrierHeight; // proportion of screen height
  final double barrierWidth; // out of 2 , where 2 is the width of the screen
  final bool isThisBottomBarrier;
  const MyBarrier({
    Key? key,
    required this.barrierHeight,
    required this.barrierWidth,
    required this.isThisBottomBarrier,
    required this.barrierX,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isThisBottomBarrier ? 1 : -1),
      child: Container(
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
        decoration: BoxDecoration(
          color: Colors.green[400],
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(10),
          //   topRight: Radius.circular(10),
          // ),
          // boxShadow: const [
          //   BoxShadow(
          //       color: Colors.black,
          //       blurRadius: 3,
          //       spreadRadius: 1,
          //       offset: Offset(1, -1.5))
          // ],
        ),
      ),
    );
  }
}
