import 'dart:io';

import 'package:dio/dio.dart';

import 'model/user_response.dart';

class UserApi {
  final Dio _client;

  UserApi(this._client);

  Future<NewUserResponse> createNewUser() async {
    var response = await _client.get(
      'v1/user/annonymous',
    );
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> json = response.data['result'];
      return NewUserResponse.fromJson(json);
    }
    return Future.error(response.data);
  }

  Future<UserResponse> fetchUserInfo() async {
    var response = await _client.get(
      'v1/user/info',
    );
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> json = response.data['result'];
      return UserResponse.fromJson(json);
    }
    return Future.error(response.data);
  }

}
