import 'package:isar/isar.dart';

part 'page_entiry.g.dart';

@collection
class PageEntity {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late String url;
  late String title;
  late String content;

  PageEntity();
}