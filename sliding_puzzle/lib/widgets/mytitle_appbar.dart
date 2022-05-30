import 'package:flutter/material.dart';
import 'package:sliding_puzzle/utils/constants.dart';

class MyTitle extends StatelessWidget with PreferredSizeWidget {
  final Size size;
  @override
  Size get preferredSize => Size(size.width, size.height * 0.08);

  const MyTitle({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.menu_sharp,
            size: size.height * 0.05,
            color: Theme.of(context).textTheme.headline1!.color,
          ),
          onPressed: () => Scaffold.of(context).openDrawer()),
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 6,
      shadowColor: Theme.of(context).shadowColor,
      title: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
        child: Center(
          child: Text("Sliderr !",
              style: titleText(context, getSize(context))),
        ),
      ),
    );
  }
}
