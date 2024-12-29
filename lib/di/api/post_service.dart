import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'model/pages_response.dart';
import 'model/post_response.dart';

class PostApi {
  final Dio _client;

  PostApi(this._client);

  Future<List<PostResponse>> getPosts({String? etag}) async {
    var response = await _client.get(
      'posts.json',
      options: Options(
        headers: {
          if (etag != null && etag.isNotEmpty)
            HttpHeaders.ifNoneMatchHeader: etag,
        },
      ),
    );
    if (response.statusCode == HttpStatus.ok) {
      var replace = response.data.replaceAll('""', '"').replaceAll(
          '"/assets/images', '"https://igorsteblii.com/assets/images');
      final List<dynamic> jsonData = jsonDecode(replace);
      return jsonData.map((json) => PostResponse.fromJson(json)).toList();
    }
    return Future.error(response.data);
  }

  Future<List<PageResponse>> getPages({String? etag}) async {
    var response = await _client.get(
      'pages.json',
      options: Options(
        headers: {
          if (etag != null && etag.isNotEmpty)
            HttpHeaders.ifNoneMatchHeader: etag,
        },
      ),
    );
    if (response.statusCode == HttpStatus.ok) {
      var replace = response.data.replaceAll('""', '"').replaceAll(
          '"/assets/images', '"https://igorsteblii.com/assets/images');
      final List<dynamic> jsonData = jsonDecode(replace);
      return jsonData.map((json) => PageResponse.fromJson(json)).toList();
    }
    return Future.error(response.data);
  }
}
