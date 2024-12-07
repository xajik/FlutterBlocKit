import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutterblockit/di/api/utils/api_client_info.dart';
import 'package:ulid/ulid.dart';


const xRequestID = "X-Request-ID";
const requestID = "Request-ID";

class AgentInterceptor extends Interceptor {
  final AppClientdInfo _appInfo;
  late final String _userAgent = _appInfo.userAgent;

  AgentInterceptor(this._appInfo);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[HttpHeaders.userAgentHeader] = _userAgent;
    options.headers[HttpHeaders.acceptEncodingHeader] = "application/json";
    
    String uniqueRequestId = Ulid().toString();
    options.headers[xRequestID] = uniqueRequestId;
    options.headers[requestID] = uniqueRequestId;
    return super.onRequest(options, handler);
  }
}