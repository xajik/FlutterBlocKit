import '../../db/entity/page_entiry.dart';

class PageResponse {
  final String title;
  final String url;
  final String content;

  PageResponse({required this.title, required this.url, required this.content});

  factory PageResponse.fromJson(Map<String, dynamic> json) {
    return PageResponse(
      title: json['title'] as String,
      url: json['url'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'content': content,
    };
  }

  PageEntity toEntity() {
    return PageEntity()
      ..title = title
      ..url = url
      ..content = content;
  }
}
