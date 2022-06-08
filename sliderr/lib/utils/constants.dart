import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle normalText(context, size) {
  return GoogleFonts.rajdhani(
      fontSize: size.height * 0.03,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.headline1?.color,
      decoration: TextDecoration.none);
}

TextStyle titleText(context, size) {
  return GoogleFonts.caveat(
      fontSize: size.height * 0.05,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.headline1?.color,
      decoration: TextDecoration.none);
}

Size getSize(context) => MediaQuery.of(context).size;

const bool kIsWeb = identical(0, 0.0);

final kLightBackground = Colors.cyan[100]!;
final kLightTextColor = Colors.deepPurple[900]!;
final kLightShadow = Colors.cyan[900]!;
final kDarkBackground = Colors.indigo[600]!;
const kDarkTextColor = Colors.white;
final kDarkShadow = Colors.indigo[100]!;
