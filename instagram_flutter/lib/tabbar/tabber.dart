import 'package:flutter/material.dart';

import '../insta_add.dart';
import '../insta_like.dart';
import '../insta_mine.dart';
import '../insta_search.dart';
import '../insta_home.dart';

class InstaTabbar extends StatefulWidget {
  InstaTabbar({Key key}) : super(key: key);

  @override
  _InstaTabbarState createState() => _InstaTabbarState();
}

class _InstaTabbarState extends State<InstaTabbar> {
  int currentIndex;

  _InstaTabbarState({this.currentIndex = 0});

  final List pages = [
    InstaHome(),
    InstaSearchPage(),
    InstaAddPage(),
    InstaLikePage(),
    InstaMinePage(),
  ];

  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text("首页"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      title: Text("搜索"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_box),
      title: Text("发现"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      title: Text("收藏"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_box),
      title: Text("我的"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        onTap: (index) {
          setState(() {
            this.currentIndex = index;
            print("tabIndex ${this.currentIndex}");
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.black87,
      ),
      body: pages[this.currentIndex],
    );
  }
}
