import 'package:flutter/material.dart';

class InstaAddPage extends StatefulWidget {
  InstaAddPage({Key key}) : super(key: key);

  @override
  _InstaAddPageState createState() => _InstaAddPageState();
}

class _InstaAddPageState extends State<InstaAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        elevation: 1.0,
        title: Text("发现", style: TextStyle(color: Colors.black87))
      ),
      body: Center(
         child: Text("发现页面", style: TextStyle(fontSize: 15)),
       ),
    );
  }
}