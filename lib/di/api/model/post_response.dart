import 'package:flutterblockit/di/db/entity/post_entity.dart';

class PostResponse {
  final String title;
  final String url;
  final DateTime date;
  final String image;

  PostResponse({
    required this.title,
    required this.url,
    required this.date,
    required this.image,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      title: json['title'] as String,
      url: json['url'] as String,
      date: DateTime.parse(json['date'] as String),
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'date': date.toIso8601String(),
      'image': image,
    };
  }

  PostEntity toEntity() {
    return PostEntity()
     ..title = title
     ..url = url
     ..date = date
     ..image = image;
  }
}