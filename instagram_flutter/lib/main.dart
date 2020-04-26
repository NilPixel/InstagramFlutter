import 'package:flutter/material.dart';
import 'tabbar/tabber.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InstaTabbar(),
    );
  }
}
