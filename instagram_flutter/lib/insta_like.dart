import 'package:flutter/material.dart';

class InstaLikePage extends StatefulWidget {
  InstaLikePage({Key key}) : super(key: key);

  @override
  _InstaLikePageState createState() => _InstaLikePageState();
}

class _InstaLikePageState extends State<InstaLikePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        elevation: 1.0,
        title: Text("收藏", style: TextStyle(color: Colors.black87))
      ),
       body: Center(
         child: Text("收藏页面", style: TextStyle(fontSize: 15)),
       ),    );
  }
}