import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'model/auth_response.dart';
import 'utils/request_utils.dart';

class SessionApi {
  final Dio _client;

  SessionApi(this._client);

  Future<AuthResponse> refreshSession(String refreshToken) async {
    String body = json.encode({"token": refreshToken});
    var response = await _client.post(
      'v1/auth/refresh',
      options: jsonContenOptions(),
      data: body,
    );
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> json = response.data['result'];
      return AuthResponse.fromJson(json);
    }
    return Future.error(response.data);
  }

  Future<AuthResponse> userKeyLogin(String userKey) async {
    String body = json.encode({"userKey": userKey});
    var response = await _client.post(
      'v1/auth/static',
      options: jsonContenOptions(),
      data: body,
    );
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> json = response.data['result'];
      return AuthResponse.fromJson(json);
    }
    return Future.error(response.data);
  }
}
