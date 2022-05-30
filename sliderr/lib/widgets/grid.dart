import 'package:flutter/material.dart';
import 'package:sliding_puzzle/utils/constants.dart';

import 'gridbutton.dart';

class Grid extends StatelessWidget {
  final List<int> numbers;
  final Size size;
  final Function clickGrid;
  const Grid({
    Key? key,
    required this.clickGrid,
    required this.size,
    required this.numbers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = size.height;

    return SizedBox(
        height: height * 0.70,
        width: kIsWeb ? size.height * 0.7 : size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: height * 0.002,
              crossAxisSpacing: height * 0.002,
            ),
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              return numbers[index] != 0
                  ? GridButton(
                      text: "${numbers[index]}",
                      click: () => clickGrid(index),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ));
  }
}
