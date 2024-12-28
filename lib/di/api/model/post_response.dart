import 'package:flutterblockit/di/db/entity/post_entity.dart';

class PostResponse {
  final String title;
  final String url;
  final DateTime date;
  final String image;
  final String content;

  PostResponse({
    required this.title,
    required this.url,
    required this.date,
    required this.image,
    required this.content,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      title: json['title'],
      url: json['url'],
      date: DateTime.parse(json['date']),
      image: json['image'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'date': date.toIso8601String(),
      'image': image,
      'content': content,
    };
  }

  PostEntity toEntity() {
    return PostEntity()
     ..title = title
     ..url = url
     ..date = date
     ..image = image
     ..content = content;
  }
}