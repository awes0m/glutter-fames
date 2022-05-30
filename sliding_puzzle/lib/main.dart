import 'package:flutter/material.dart';
import 'package:sliding_puzzle/board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sliderrrrrr',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const Board(),
    );
  }
}
