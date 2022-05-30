import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback reset;
  const ResetButton({Key? key, required this.reset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: reset,
      style: TextButton.styleFrom(
        primary: Colors.white,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: const Text("Reset",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
    );
  }
}
