import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final Size size;
  const MyTitle({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.1,
      padding: const EdgeInsets.all(5.0),
      child: Text("Sliderrrr !",
          style: TextStyle(
              fontSize: size.height * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.none)),
    );
  }
}
