import 'package:flutter/material.dart';
import 'package:sliding_puzzle/board.dart';
import 'package:sliding_puzzle/utils/constants.dart';
import 'package:sliding_puzzle/utils/theme_model.dart';

Widget drawer(BuildContext context, ThemeModel themeNotifier) {
  ScrollController scrollController = ScrollController();
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
            child: Column(
              children: [
                Text(
                  'Sliderr !',
                  style: titleText(context, getSize(context)),
                ),
                Text(
                  'Version: 1.0.1',
                  style: normalText(context, getSize(context)),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Row(children: [
            Text(
              themeNotifier.isDark ? "Velvet Finish " : "Card Finish",
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
                      actions: [
                        TextButton(
                          child: Text(
                            "OK",
                            style: normalText(context, getSize(context)),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                      title: Text(
                        "Sliderr !",
                        style: titleText(context, getSize(context)),
                      ),
                      content: SizedBox(
                        width: kIsWeb
                            ? getSize(context).width * 0.5
                            : getSize(context).width * 0.8,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            SizedBox(
                              height: getSize(context).height * 0.3,
                              width: kIsWeb
                                  ? getSize(context).width * 0.5
                                  : getSize(context).width * 0.8,
                              child: Text(
                                "SLide the pices to the empty space to get the puzzle solved.\nStart from 1 at Top Left Corner and end blank at the bottom right corner.\nYou can move the pices by swiping left, right, up and down.",
                                style: normalText(context, getSize(context)),
                              ),
                            ),
                            ListTile(
                              subtitle: Center(
                                child: Text(
                                  'Win Condition',
                                  style: normalText(context, getSize(context)),
                                ),
                              ),
                              title: Container(
                                height: kIsWeb
                                    ? getSize(context).height * 0.4
                                    : getSize(context).height * 0.3,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                    image:
                                        AssetImage('assets/win_condition.jpg'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getSize(context).height * 0.3,
                              width: kIsWeb
                                  ? getSize(context).width * 0.5
                                  : getSize(context).width * 0.8,
                              child: Text(
                                "1  2  3  4 \n5  6  7  8 \n9  10 11 12 \n13 14 15  _",
                                style: normalText(context, getSize(context)),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ));
          },
        ),
        ListTile(
          subtitle: Center(
            child: Text(
              'Win Condition',
              style: normalText(context, getSize(context)),
            ),
          ),
          title: Container(
            height: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/win_condition.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
