import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base/provide/insta_base_provide2.dart';
import 'insta_add.dart';
import 'insta_home.dart';
import 'insta_like.dart';
import 'insta_mine.dart';
import 'insta_search.dart';
import 'viewmodel/insta_main_provide.dart';

class App extends PageProvideNode2 {
  App() {
//    mProviders.add(MainProvide.instance);
//    mProviders = MainProvide.instance;
  }
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return _AppContentPage();
  }
}

class _AppContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<_AppContentPage>
    with TickerProviderStateMixin<_AppContentPage> {
  MainProvide _provide;
  TabController controller;
  final List<Widget> pages = [
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

  Animation<double> _animationMini;
  AnimationController _miniController;
  final _tranTween = new Tween<double>(begin: 1, end: 0);

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _provide = MainProvide.instance;

    controller = new TabController(length: 3, vsync: this);

    _miniController = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationMini =
        new CurvedAnimation(parent: _miniController, curve: Curves.linear);
  }

  @override
  void dispose() {
    super.dispose();
    print("app释放");
  }

  ontap(int index) {
    _provide.currentIndex = index;
    controller.animateTo(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _provide,
      child: new Scaffold(
          body: new Stack(
            alignment: AlignmentDirectional.bottomEnd,
            overflow: Overflow.visible,
            children: <Widget>[_initTabBarView()],
          ),
          bottomNavigationBar: _initBottomNavigationBar()),
    );
  }

  // TabBarView存在页面释放问题
//  Widget _initTabBarView() {
//    return new TabBarView(
//      controller: controller,
//      physics: NeverScrollableScrollPhysics(),
//      children: [
//        _home,
//        _old,
//        _mine,
//      ],
//    );
//  }

  Widget _initTabBarView() {
    return Consumer(builder:
        (BuildContext context, MainProvide mainProvider, Widget child) {
      return IndexedStack(
        index: _provide.currentIndex,
        children: pages,
      );
    });
  }

  // Widget _initMiniPlayer() {
  //   return Consumer(builder:
  //       (BuildContext context, MainProvide mainProvider, Widget child) {
  //     return Visibility(
  //       visible: mainProvider.showMini,
  //       child: new FadeTransition(
  //         opacity: _tranTween.animate(_animationMini),
  //         child: new Container(
  //           width: 80,
  //           height: 110,
  //           child: _miniPage,
  //         ),
  //       ),
  //     );
  //   });
  // }

  Widget _initBottomNavigationBar() {
    return Theme(
        data: new ThemeData(
            canvasColor: Colors.white, // BottomNavigationBar背景色
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.grey))),
        child: Consumer(builder:
            (BuildContext context, MainProvide mainProvider, Widget child) {
          return BottomNavigationBar(
              fixedColor: Colors.black87,
              currentIndex: mainProvider.currentIndex,
              onTap: ontap,
              type: BottomNavigationBarType.fixed,
              items: bottomNavItems);
        }));
  }
}
