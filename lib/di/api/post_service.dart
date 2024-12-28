import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:html_unescape/html_unescape.dart';

import 'model/pages_response.dart';
import 'model/post_response.dart';

class PostApi {
  final Dio _client;

  PostApi(this._client);

  Future<List<PostResponse>> getPosts() async {
    var response = await _client.get(
      'posts.json',
    );
    if (response.statusCode == HttpStatus.ok) {
      var replace = response.data.replaceAll('""', '"');
      final List<dynamic> jsonData = jsonDecode(replace);
      return jsonData.map((json) => PostResponse.fromJson(json)).toList();
    }
    return Future.error(response.data);
  }

  Future<List<PageResponse>> getPages() async {
    var response = await _client.get(
      'pages.json',
    );
    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> jsonData = jsonDecode(response.data);
      return jsonData.map((json) => PageResponse.fromJson(json)).toList();
    }
    return Future.error(response.data);
  }
}
