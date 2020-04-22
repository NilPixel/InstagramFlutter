import 'package:flutter/material.dart';

class InstaMinePage extends StatefulWidget {
  InstaMinePage({Key key}) : super(key: key);

  @override
  _InstaMinePageState createState() => _InstaMinePageState();
}

class _InstaMinePageState extends State<InstaMinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        elevation: 1.0,
        title: Text("我的", style: TextStyle(color: Colors.black87))
      ),
      body: Center(
        child: Text("我的页面", style: TextStyle(fontSize: 15)),
      ),    );
  }
}