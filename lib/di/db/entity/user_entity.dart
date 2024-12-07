import 'package:isar/isar.dart';

part 'user_entity.g.dart';

@collection
class UserEntity {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late int userId;
  late String? name;
  late String? surname;
  late String nickname;
  late String? email;
  late String uniqueKey;

  UserEntity();

}