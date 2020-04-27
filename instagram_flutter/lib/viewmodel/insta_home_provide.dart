import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_flutter/base/provide/insta_base_provide.dart';
import 'package:rxdart/rxdart.dart';
import 'package:instagram_flutter/base/insta_config.dart';
import 'package:instagram_flutter/data/insta_song.dart';
import 'package:instagram_flutter/utils/media/insta_player.dart';
import 'package:instagram_flutter/model/insta_home_model.dart';

class HomeProvide extends BaseProvide {
  // 页数
  int _page = 0;
  int get page => _page;
  set page(int page) {
    _page = page;
  }

  final subjectMore = new BehaviorSubject<bool>();

  bool _hasMore = false;
  bool get hasMore => _hasMore;
  set hasMore(bool hasMore) {
    _hasMore = hasMore;
    subjectMore.add(hasMore);
  }


  List<Song> _dataArr = [];
  List<Song> get dataArr => _dataArr;
  set dataArr(List<Song> arr) {
    _dataArr = arr;
    this.notify();
  }

  int _count = 0;
  int get count => _count;
  set count(int count) {
    _count = count;
    notify();
  }
  expand(int index) {
    this.count = index;
    this.dataArr[index].isExpaned = !this.dataArr[index].isExpaned;
    notify();
  }

  final HomeRepo _repo = HomeRepo();

  notify() {
    notifyListeners();
  }

  setSongs(int index) {
    PlayerTools.instance.setSongs(this.dataArr, index);
  }

  Stream getSongs(bool isRefrsh) {
    isRefrsh ? page = 0 : page++;
    var query = {
      'page': this.page,
      'pageSize': 30,
      'orderkey': 'imgUrl',
      'sequence': true,
      'searchKey': '',
      'userId': null
    };
    return _repo
        .getSongs(query)
        .doOnData((result) {
          if (isRefrsh) {
            this.dataArr.clear();
          }
          var arr = result.data as List;
          this.dataArr.addAll(arr.map((map) => Song.fromJson(map)));

          this.hasMore = result.total > this.dataArr.length;

          this.notify();
    })
        .doOnError((e, stacktrace) {
        })
        .doOnListen(() {
        })
        .doOnDone(() {
        });
  }

  /// 收藏
  Stream collectionSong(String songId) {
    return _repo
        .collectionSong(songId)
        .doOnData((result) {

          int index = this.dataArr.indexWhere((song) {
            return song.id == songId;
          });
          this.dataArr[index].isFav = true;
          this.notify();
    })
        .doOnError((e, stacktrace) {
    })
        .doOnListen(() {
    })
        .doOnDone(() {
    });
  }
  /// 取消收藏
  Stream uncollectionSong(String songId) {
    return _repo
        .uncollectionSong(songId)
        .doOnData((result) {

          int index = this.dataArr.indexWhere((song) {
           return song.id == songId;
          });
          this.dataArr[index].isFav = false;
          this.notify();

          Fluttertoast.showToast(
              msg: "取消收藏成功",
              gravity: ToastGravity.CENTER
          );
    })
        .doOnError((e, stacktrace) {
    })
        .doOnListen(() {
    })
        .doOnDone(() {
    });
  }
}