import 'package:dio/dio.dart';
import 'package:instagram_flutter/base/insta_config.dart';

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  BaseOptions options;

  static HttpUtil getInstance() {
    print('getInstance');
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }

  HttpUtil() {
    dio = new Dio()
      ..options = BaseOptions(
          baseUrl: AppConfig.baseUrl,
          connectTimeout: 30000,
          receiveTimeout: 30000)
      ..interceptors.add(HeaderInterceptor());
  }
}

class HeaderInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) {
    final token = '';
    if (token != null && token.length > 0) {
      options.headers
          .putIfAbsent("Authorization", () => "Bearer" + " " + token);
    }
    // TODO: implement onRequest
    return super.onRequest(options);
  }
}
