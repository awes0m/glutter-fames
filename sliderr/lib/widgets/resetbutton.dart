import 'package:flutter/material.dart';
import 'package:sliding_puzzle/utils/constants.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback reset;
  const ResetButton({Key? key, required this.reset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: reset,
      style: TextButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text("Restart", style: normalText(context, getSize(context))),
    );
  }
}
