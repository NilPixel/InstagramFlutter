import 'package:flutter/material.dart';
import 'insta_list.dart';

class InstaBodyStateful extends StatefulWidget {
  InstaBodyStateful({Key key}) : super(key: key);

  @override
  _InstaBodyStatefulState createState() => _InstaBodyStatefulState();
}

class _InstaBodyStatefulState extends State<InstaBodyStateful> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Expanded(flex: 1, child: new InstaStories()),
          Flexible(child: InstaList())
        ],
      ),
    );
  }
}
