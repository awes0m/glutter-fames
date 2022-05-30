import 'package:flutter/material.dart';

class GridButton extends StatelessWidget {
  final VoidCallback click;
  final String text;
  const GridButton({Key? key, required this.click, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: click,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        primary: Colors.white,
        surfaceTintColor: Colors.amber,
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black26,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
