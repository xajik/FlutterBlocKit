import '../../db/entity/user_entity.dart';
import 'auth_response.dart';

class UserResponse {
  final int id;
  final String? name;
  final String? surname;
  final String nickName;
  final String? email;
  final String uniqueKey;

  UserResponse(this.id, this.name, this.surname, this.nickName, this.email,
      this.uniqueKey);

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      json["id"],
      json["name"],
      json["surname"],
      json["nick_name"],
      json["email"],
      json["unique_key"],
    );
  }

  Map<String, dynamic> toJson() {
    final json = {
      "id": id,
      "name": name,
      "surname": surname,
      "nick_name": nickName,
      "email": email,
      "uniqueKey": uniqueKey,
    };
    json.removeWhere((key, value) => value == null || value == "");
    return json;
  }

  UserResponse copyWith(
      {int? id,
      String? name,
      String? surname,
      String? nickName,
      String? email,
      String? uniqueKey}) {
    return UserResponse(
        id ?? this.id,
        name ?? this.name,
        surname ?? this.surname,
        nickName ?? this.nickName,
        email ?? this.email,
        uniqueKey ?? this.uniqueKey);
  }

  UserEntity toUserEntity() {
    return UserEntity()
      ..userId = id
      ..name = name
      ..surname = surname
      ..nickname = nickName
      ..email = email
      ..uniqueKey = uniqueKey;
  }
}


class NewUserResponse {
  final UserResponse user;
  final AuthResponse auth;

  NewUserResponse(this.user, this.auth);

  factory NewUserResponse.fromJson(Map<String, dynamic> json) {
    return NewUserResponse(
      UserResponse.fromJson(json["user"]),
      AuthResponse.fromJson(json["auth"]),
    );
  }
}