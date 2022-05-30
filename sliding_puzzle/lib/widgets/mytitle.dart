import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTitle extends StatelessWidget with PreferredSizeWidget {
  final Size size;
  @override
  Size get preferredSize => Size(size.width, size.height * 0.08);

  const MyTitle({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 6,
      shadowColor: Colors.blueGrey,
      title: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
        child: Center(
          child: Text("Sliderr !",
              style: TextStyle(
                  fontSize: size.height * 0.05,
                  fontFamily: GoogleFonts.lobster().fontFamily,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  decoration: TextDecoration.none)),
        ),
      ),
    );
  }
}
