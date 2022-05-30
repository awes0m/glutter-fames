import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
          ),
          child: Text(
            'Sliderrrrrr',
            style: TextStyle(
                fontSize: 30,
                fontFamily: GoogleFonts.lobster().fontFamily,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
