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
        elevation: 30,
        primary: Theme.of(context).primaryColor,
        shadowColor: Theme.of(context).shadowColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).shadowColor.withOpacity(0.2),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.headline1?.color,
        ),
      ),
    );
  }
}
