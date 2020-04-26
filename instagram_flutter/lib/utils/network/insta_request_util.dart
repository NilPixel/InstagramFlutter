import 'dart:async';
import 'package:instagram_flutter/utils/network/insta_http_util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_flutter/data/insta_base.dart';

Stream<BaseResponse> get(String url, {Map<String, dynamic> params}) =>
    Stream.fromFuture(_get(url, params: params)).delay(Duration(milliseconds: 500)).asBroadcastStream();

Future<BaseResponse> _get(String url, {Map<String, dynamic> params}) async {
  var response = await HttpUtil().dio.get(url, queryParameters: params);
  var res = BaseResponse.fromJson(response.data);
  if (res.success == false) {
    Fluttertoast.showToast(
        msg: res.message
    );
  }
  return res;
}

Stream<BaseResponse> post(String url,{dynamic body,Map<String, dynamic> queryParameters}) =>
    Stream.fromFuture(_post(url, body,queryParameters: queryParameters)).delay(Duration(milliseconds: 500)).asBroadcastStream();

Future<BaseResponse> _post(String url, dynamic body,{ Map<String, dynamic> queryParameters}) async {
  var response = await HttpUtil().dio.post(url, data: body, queryParameters: queryParameters);
  var res = BaseResponse.fromJson(response.data);
  if (res.success == false) {
    Fluttertoast.showToast(
        msg: res.message,
        gravity: ToastGravity.CENTER
    );
  }
  return res;
}