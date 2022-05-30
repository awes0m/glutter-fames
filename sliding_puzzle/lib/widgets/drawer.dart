import 'package:flutter/material.dart';
import 'package:sliding_puzzle/board.dart';
import 'package:sliding_puzzle/utils/constants.dart';
import 'package:sliding_puzzle/utils/theme_model.dart';

Widget drawer(BuildContext context, ThemeModel themeNotifier) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () => Navigator.popUntil(
                context, (route) => Board.routeName == route.settings.name),
            child: Text(
              'Sliderr !',
              style: titleText(context, getSize(context)),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Row(children: [
            Text(
              themeNotifier.isDark ? "Dark Theme " : "Light Theme",
              style: normalText(context, getSize(context)),
            ),
            IconButton(
                icon: Icon(themeNotifier.isDark
                    ? Icons.nightlight_round
                    : Icons.wb_sunny),
                onPressed: () {
                  themeNotifier.isDark
                      ? themeNotifier.isDark = false
                      : themeNotifier.isDark = true;
                }),
          ]),
          onTap: () {
            themeNotifier.isDark
                ? themeNotifier.isDark = false
                : themeNotifier.isDark = true;
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title:
              Text('How to Play', style: normalText(context, getSize(context))),
          onTap: () {
            showDialog(
              barrierColor: Theme.of(context).primaryColor.withOpacity(0.2),
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Sliderr !"),
                content: const SingleChildScrollView(
                  child: Text(
                    """A sliding puzzle, sliding block puzzle, or sliding tile puzzle is a combination puzzle that challenges a player to slide (frequently flat) pieces along certain routes (usually on a board) to establish a certain end-configuration.
                 
                The pieces to be moved may consist of simple shapes, or they may be imprinted with colours, patterns, sections of a larger picture (like a jigsaw puzzle), numbers, or letters.
              """,
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "OK",
                      style: normalText(context, getSize(context)),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}
