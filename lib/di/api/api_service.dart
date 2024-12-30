import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterblockit/di/api/session_api.dart';
import 'package:flutterblockit/di/api/user_api.dart';
import 'package:flutterblockit/di/db/etag_repo.dart';
import 'dart:developer' as developer;

import 'interceptors/agent_request_interceptor.dart';
import 'interceptors/token_request_interceptor.dart';
import 'interceptors/unauthorised_response_interceptor.dart';
import 'post_service.dart';
import 'utils/api_client_info.dart';

class ApiService {
  final PostApi postApi;
  final SessionApi sessionApi;
  final UserApi userApi;

  ApiService({
    required this.postApi,
    required this.sessionApi,
    required this.userApi,
  });

  factory ApiService._(Dio client, EtagRepo etag) {
    return ApiService(
      postApi: PostApi(client, etag),
      sessionApi: SessionApi(client),
      userApi: UserApi(client),
    );
  }
}

mixin ApiServiceFactory {
  //TODO: Update
  static const _baseUrl =
      kReleaseMode ? "https://igorsteblii.com" : "https://igorsteblii.com";

  static Future<ApiService> create(
    Stream<String?> session,
    StreamController<bool> unauthorizedStream,
    EtagRepo etagRepo,
  ) async {
    final buildInfo = await AppClientInfoUtils.buildInfo;
    final agentInterceptor = AgentInterceptor(buildInfo);

    final tokenInterceptor = TokenInterceptor(session);
    final sessionInterceptor = SessionInterceptor(unauthorizedStream);

    BaseOptions options = BaseOptions(
      baseUrl: "$_baseUrl/",
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.plain,
      followRedirects: true,
      validateStatus: (status) => status != null && (status >= 200 && status < 300) || status == 304,
    );

    final logInterceptor = LogInterceptor(
      requestBody: true,
      requestHeader: kDebugMode,
      responseHeader: true,
      logPrint: (o) => developer.log(o.toString(), name: "Http Client Logs"),
    );

    final authentificatedDio = Dio(options)
      ..interceptors.addAll([
        agentInterceptor,
        tokenInterceptor,
        sessionInterceptor,
      ])
      ..interceptors.add(
        logInterceptor,
      );

    return ApiService._(authentificatedDio, etagRepo);
  }
}
