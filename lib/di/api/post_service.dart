import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutterblockit/di/db/etag_repo.dart';

import 'model/pages_response.dart';
import 'model/post_response.dart';

class PostApi {
  final Dio _client;
  final EtagRepo _etagRepo;

  PostApi(this._client, this._etagRepo);

  Future<List<PostResponse>> getPosts() async {
    const url = 'posts.json';
    String? etag = (await _etagRepo.getByKey(url))?.value;
    var response = await _client.get(
      url,
      options: Options(
        headers: {
          if (etag != null && etag.isNotEmpty)
            HttpHeaders.ifNoneMatchHeader: etag,
        },
      ),
    );
    if (response.statusCode == HttpStatus.ok) {
      final replace = _formatJekyllResponse(response.data);
      final List<dynamic> jsonData = jsonDecode(replace);
      final etag = response.headers.value(HttpHeaders.etagHeader);
      if (etag != null) await _etagRepo.insert(url, etag);
      return jsonData.map((json) => PostResponse.fromJson(json)).toList();
    } else if (response.statusCode == HttpStatus.notModified) {
      return [];
    }
    return Future.error(response.data);
  }

  Future<List<PageResponse>> getPages({String? etag}) async {
    const url = 'pages.json';
    String? etag = (await _etagRepo.getByKey(url))?.value;
    var response = await _client.get(
      url,
      options: Options(
        headers: {
          if (etag != null && etag.isNotEmpty)
            HttpHeaders.ifNoneMatchHeader: etag,
        },
      ),
    );
    if (response.statusCode == HttpStatus.ok) {
      final replace = _formatJekyllResponse(response.data);
      final List<dynamic> jsonData = jsonDecode(replace);
      final etag = response.headers.value(HttpHeaders.etagHeader);
      if (etag != null) await _etagRepo.insert(url, etag);
      return jsonData.map((json) => PageResponse.fromJson(json)).toList();
    } else if (response.statusCode == HttpStatus.notModified) {
      return [];
    }
    return Future.error(response.data);
  }

  String _formatJekyllResponse(String response) {
    return response.replaceAll('""', '"').replaceAll(
        '"/assets/images', '"https://igorsteblii.com/assets/images');
  }
}
