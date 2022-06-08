import 'package:flutter/material.dart';

class NeuGridButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double textSize;
  final double hPadding;
  final double vPadding;

  final VoidCallback onPressed;
  final double boxRadius;
  const NeuGridButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.textColor = Colors.white,
    this.boxRadius = 10,
    this.textSize = 30,
    this.hPadding = 5,
    this.vPadding = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(boxRadius),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: ThemeData.estimateBrightnessForColor(
                          Theme.of(context).primaryColor) ==
                      Brightness.dark
                  ? Colors.white54
                  : Colors.black54,
              offset: const Offset(-2, -2),
              blurRadius: 10,
              spreadRadius: -5,
            ),
            BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: const Offset(2, 2),
              blurRadius: 10,
              spreadRadius: -5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: textSize,
            ),
          ),
        ),
      ),
    );
  }
}
