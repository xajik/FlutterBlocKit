import 'dart:convert';

import '../../db/entity/session_entity.dart';

class AuthResponse {
  final TokenResponse token;
  final TokenResponse refreshToken;

  AuthResponse(this.token, this.refreshToken);

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      TokenResponse.fromJson(json["token"]),
      TokenResponse.fromJson(json["refresh_token"]),
    );
  }

  SessionEntity toEntity(int userId) {
    return SessionEntity()
      ..userId = userId
      ..accessToken = token.toEntity()
      ..refreshToken = refreshToken.toEntity();
  }
}

class TokenResponse {
  final String token;
  final String issuedAt;
  final String expiredAt;

  TokenResponse(this.token, this.issuedAt, this.expiredAt);

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      json["token"],
      json["iat"],
      json["expire"],
    );
  }

  String toJson() {
    return json.encode(this);
  }

  TokenEntity toEntity() {
    return TokenEntity()
      ..token = token
      ..issuedAt = issuedAt
      ..expiredAt = expiredAt;
  }
}
