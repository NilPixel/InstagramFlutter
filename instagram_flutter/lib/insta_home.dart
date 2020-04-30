import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_flutter/widget/dialog/insta_dialog.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'base/insta_config.dart';
import 'insta_stories.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'viewmodel/insta_home_provide.dart';
import 'utils/common/insta_adapt.dart';

class InstaHome extends StatefulWidget {
  InstaHome({Key key}) : super(key: key);

  @override
  _InstaHomeState createState() => _InstaHomeState();
}

class _InstaHomeState extends State<InstaHome> {
  final topBar = new AppBar(
    backgroundColor: new Color(0xfff8faf8),
    centerTitle: true,
    elevation: 1.0,
    leading: new Icon(Icons.camera_alt, color: Colors.black87),
    title: SizedBox(
        height: 35.0, child: Image.asset("assets/images/insta_logo.png")),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Icon(Icons.send, color: Colors.black87),
      )
    ],
  );

  final _subscriptions = CompositeSubscription();
  final _loading = LoadingDialog();
  final _cellHeight = 80.0;

  bool get wantKeepAlive => true;
  HomeProvide _provide = HomeProvide();

  RefreshController _controller = RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    _provide.subjectMore.listen((hasMore) {
      if (hasMore) {
        _controller.refreshToIdle();
      } else {
        if (_provide.dataArr.length > 0) {
          _controller.loadNoData();
        }
      }
    });
  }

  _loadData([bool isRefresh = true]) {
    var s = _provide.getSongs(isRefresh).listen((data) {
      if (isRefresh) {
        _controller.refreshCompleted();
        _controller.resetNoData();
      } else {
        _controller.loadComplete();
      }
    }, onError: (e) {
      if (isRefresh) {
        _controller.refreshFailed();
      } else {
        _controller.loadFailed();
      }
    });
    _subscriptions.add(s);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provide,
      child: Scaffold(
        appBar: topBar,
        body: _initView(),
      ),
    );
  }

  Widget _initView() {
    return Consumer<HomeProvide>(
      builder: (build, provide, _) {
        print('Consumer-initView');
        return _provide.dataArr.length > 0
            ? _buildListView()
            : AppConfig.initLoading(false);
      },
    );
  }

  Widget _buildListView() {
    var deviceSize = MediaQuery.of(context).size;

    return SmartRefresher(
        controller: _controller,
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemCount: _provide.dataArr.length + 1,
          itemBuilder: (context, index) => index == 0
              ? new SizedBox(
                  child: new InstaStories(),
                  height: Adapt.px(245),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              new ClipOval(
                                child: new CachedNetworkImage(
                                  width: 40.0,
                                  height: 40.0,
                                  imageUrl:
                                      _provide.dataArr[index - 1].imgUrl,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error_outline),
                                ),
                              ),
                              new SizedBox(
                                width: 10.0,
                              ),
                              new Text(
                                "imthpk",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          new IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: null,
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: new CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            _provide.dataArr[index - 1].imgUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset("assets/images/insta_default.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Icon(
                                FontAwesomeIcons.heart,
                              ),
                              new SizedBox(
                                width: 16.0,
                              ),
                              new Icon(
                                FontAwesomeIcons.comment,
                              ),
                              new SizedBox(
                                width: 16.0,
                              ),
                              new Icon(FontAwesomeIcons.paperPlane),
                            ],
                          ),
                          new Icon(FontAwesomeIcons.bookmark)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        _provide.dataArr[index - 1].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new ClipOval(
                            child: CachedNetworkImage(
                                width: 40.0,
                                height: 40.0,
                                fit: BoxFit.fill,
                                imageUrl:
                                    "http://n.sinaimg.cn/tech/crawl/0/w400h400/20200422/de9a-isqivxf9857884.jpg",
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error_outline)),
                          ),
                          new SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: new TextField(
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "Add a comment...",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(_provide.dataArr[index - 1].singer,
                          style: TextStyle(color: Colors.grey)),
                    )
                  ],
                ),
        ));
  }

  void _onRefresh() async {
    _loadData();
  }

  void _onLoading() async {
    if (_provide.hasMore) {
      _loadData(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    print("首页释放");
    _subscriptions.dispose();
  }
}
