import 'package:flutter/material.dart';
import 'package:news_app/views/search.dart';

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
    //custom appbar
    return AppBar(
      backgroundColor: Colors.grey.shade900,
      elevation:10,
      shadowColor: Colors.grey.shade500,
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
        ),
        IconButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search())),
          icon: Icon(Icons.search,size: 26,
        ),)
      ],
      centerTitle: true,
    );
  }
}
