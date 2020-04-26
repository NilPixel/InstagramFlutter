import 'package:instagram_flutter/utils/network/insta_request_util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:instagram_flutter/data/insta_base.dart';
import 'package:instagram_flutter/base/insta_config.dart';

class HomeService {
  /// 获取列表
  Stream<BaseResponse> getSongs(dynamic request, Map<String, dynamic> query) {
    var url = 'api/song/list';
    var response = post(url, body: request, queryParameters: query);
    return response;
  }

  /// 收藏歌曲
  Stream<BaseResponse> collectionSong(String songId) {
    var body = {
      'userId': AppConfig.userTools.getUserId(),
      'songId': songId,
      'songType': 0
    };
    var url = 'api/song/collectionSong';
    var response = post(url, body: body, queryParameters: null);
    return response;
  }

  /// 取消收藏
  Stream<BaseResponse> uncollectionSong(String songId) {
    var body = {'userId': AppConfig.userTools.getUserId(), 'songId': songId};
    var url = 'api/song/uncollectionSong';
    var response = post(url, body: body, queryParameters: null);
    return response;
  }

  /// 评论列表
  Stream<BaseResponse> commentList(int page, String songId) {
    var param = {'page': page, 'pageSize': 30, 'songId': songId};
    var url = 'api/song/comment/list';
    var response = get(url, params: param);
    return response;
  }

  /// 发布评论
  Stream<BaseResponse> sendComment(String content, String songId) {
    var body = {
      'content': content,
      'userId': AppConfig.userTools.getUserId(),
      'songId': songId
    };
    var url = 'api/song/comment/submit';
    var response = post(url, body: body);
    return response;
  }

  /// 点赞
  Stream<BaseResponse> niceComment(String commentId) {
    var body = {'commentId': commentId};
    var url = 'api/song/comment/nice';
    var response = post(url, body: body);
    return response;
  }
}

class HomeRepo {
  final HomeService _remote = HomeService();

  Stream<BaseResponse> getSongs(Map<String, dynamic> query) {
    return _remote.getSongs(null, query);
  }

  Stream<BaseResponse> collectionSong(String songId) {
    return _remote.collectionSong(songId);
  }

  Stream<BaseResponse> uncollectionSong(String songId) {
    return _remote.uncollectionSong(songId);
  }

  Stream<BaseResponse> commentList(int page, String songId) {
    return _remote.commentList(page, songId);
  }

  Stream<BaseResponse> sendComment(String content, String songId) {
    return _remote.sendComment(content, songId);
  }

  Stream<BaseResponse> niceComment(String commentId) {
    return _remote.niceComment(commentId);
  }
}
