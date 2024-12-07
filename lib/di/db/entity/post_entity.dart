import 'package:isar/isar.dart';

part 'post_entity.g.dart';

@collection
class PostEntity {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late String url;
  late String title;
  late DateTime date;
  late String image;

  PostEntity();
}