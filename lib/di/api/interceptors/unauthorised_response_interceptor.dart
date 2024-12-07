import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class SessionInterceptor extends Interceptor {
  final StreamSink<bool> _unauthorized;

  SessionInterceptor(this._unauthorized);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == HttpStatus.unauthorized) {
      _unauthorized.add(true);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      _unauthorized.add(true);
    }
    super.onError(err, handler);
  }
}
