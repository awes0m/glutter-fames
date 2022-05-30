import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback reset;
  const ResetButton({Key? key, required this.reset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ElevatedButton(
          onPressed: reset,
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: const Text("Reset")),
    );
  }
}
