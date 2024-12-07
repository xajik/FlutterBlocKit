import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'model/post_response.dart';

class PostApi {
  final Dio _client;

  PostApi(this._client);

  Future<List<PostResponse>> getPosts() async {
    var response = await _client.get(
      'posts.json',
    );
    if (response.statusCode == HttpStatus.ok) {
       final List<dynamic> jsonData = json.decode(response.data);
      return jsonData.map((json) => PostResponse.fromJson(json)).toList();
    }
    return Future.error(response.data);
  }

}