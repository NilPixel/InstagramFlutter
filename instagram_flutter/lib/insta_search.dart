import 'package:flutter/material.dart';

class InstaSearchPage extends StatefulWidget {
  InstaSearchPage({Key key}) : super(key: key);

  @override
  _InstaSearchPageState createState() => _InstaSearchPageState();
}

class _InstaSearchPageState extends State<InstaSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        elevation: 1.0,
        title: Text("搜索", style: TextStyle(color: Colors.black87))
      ),
      body: Center(
         child: Text("搜索页面", style: TextStyle(fontSize: 15)),
       ),
    );
  }
}