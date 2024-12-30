import 'package:isar/isar.dart';

part 'etag_entity.g.dart';

@collection
class EtagEntity {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late String key;
  late String value;

  EtagEntity();
}