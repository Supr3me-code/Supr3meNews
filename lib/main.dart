import 'package:flutter/material.dart';
import 'views/home.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        canvasColor: Colors.black
      ),
      home: Home(),
    );
  }
}

