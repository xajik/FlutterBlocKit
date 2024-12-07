import 'package:isar/isar.dart';

part 'session_entity.g.dart';

@collection
class SessionEntity {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late int userId;
  late TokenEntity accessToken;
  late TokenEntity refreshToken;

  SessionEntity();
}

@embedded
class TokenEntity {
  late String token;
  late String issuedAt;
  late String expiredAt;
}
