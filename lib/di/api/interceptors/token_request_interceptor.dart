import 'dart:io';

import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  String? _authToken;

  TokenInterceptor(Stream<String?> session) {
    session.listen((event) {
      _authToken = event;
    });
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_authToken?.isNotEmpty == true) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $_authToken';
    }
    return super.onRequest(options, handler);
  }
}