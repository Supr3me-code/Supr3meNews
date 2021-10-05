import 'package:flutter/material.dart';

class Supr3meAppBar extends StatefulWidget implements PreferredSizeWidget {
  Supr3meAppBar({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _Supr3meAppBarState createState() => _Supr3meAppBarState();
}

class _Supr3meAppBarState extends State<Supr3meAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Supr3me",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "News",
            style: TextStyle(color: Colors.deepOrange),
          )
        ],
      ),
      actions: <Widget>[
        Opacity(
          opacity: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.account_balance_sharp),
          ),
        )
      ],
      centerTitle: true,
      elevation: 0.0,
    );
  }
}
