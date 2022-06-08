import 'package:flutter/material.dart';
import 'package:sliding_puzzle/utils/constants.dart';
import 'package:sliding_puzzle/utils/theme_model.dart';
import 'package:sliding_puzzle/widgets/neu_grid_button.dart';

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
        //main container
        height: height * 0.70,
        width: kIsWeb ? size.height * 0.7 : size.width,
        child: Container(
          // inner puzzle box
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            backgroundBlendMode: BlendMode.darken,
            borderRadius: BorderRadius.circular(1),
            boxShadow: [
              BoxShadow(
                  color: isDark(context) ? Colors.black38 : Colors.black12,
                  blurRadius: 20,
                  spreadRadius: -10),
              BoxShadow(
                  color: isDark(context)
                      ? kDarkShadow.withOpacity(0.3)
                      : kLightShadow.withOpacity(0.3),
                  offset: const Offset(-4, -4),
                  blurRadius: 20,
                  spreadRadius: -30),
            ],
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: height * 0.005,
              crossAxisSpacing: height * 0.005,
            ),
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              return numbers[index] != 0
                  // ? GridButton(
                  //     text: "${numbers[index]}",
                  //     click: () => clickGrid(index),
                  //   )
                  ? NeuGridButton(
                      text: "${numbers[index]}",
                      backgroundColor: Theme.of(context).primaryColor,
                      onPressed: () => clickGrid(index),
                      textColor:
                          isDark(context) ? kDarkTextColor : kLightTextColor,
                      boxRadius: 5,
                      textSize: 30,
                      hPadding: 5,
                      vPadding: 5,
                    )
                  : const SizedBox.shrink();
            },
          ),
        ));
  }
}
