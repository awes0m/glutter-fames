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
