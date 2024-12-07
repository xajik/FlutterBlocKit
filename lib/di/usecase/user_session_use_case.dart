import 'dart:async';

import '../analytics/app_analytics.dart';
import '../api/session_api.dart';
import '../api/user_api.dart';
import '../db/entity/user_entity.dart';
import '../db/session_repo.dart';
import '../db/user_repo.dart';


class UserSessionUseCase {
  final UserRepo _userRepo;
  final SessionRepo _sessionRepo;
  final UserApi _userApi;
  final SessionApi _sessionApi;
  final AppAnalytics _analytics;

  UserSessionUseCase(
    this._userRepo,
    this._sessionRepo,
    this._userApi,
    this._sessionApi,
    this._analytics,
  );

  Future<void> createUser({bool forceRefresh = false}) async {
    final user = await _userRepo.first();
    if (user == null) {
      final newUser = await _userApi.createNewUser();
      await _userRepo.insert(newUser.user.toUserEntity());
      await _sessionRepo.insert(newUser.auth.toEntity(newUser.user.id));
      await _analytics.reportNewUserCreated(newUser.user.id);
    } else {
      final session = await _sessionRepo.getSession(user.userId);
      if (session == null) {
        await _createUserSession(user.uniqueKey, user.userId);
      } else {
        if (forceRefresh) {
          refreshOrCreate(user, session.refreshToken.token);
        } else {
          final expired = _tokenExpired(
              session.accessToken.token, session.accessToken.expiredAt);
          if (expired || forceRefresh) {
            final expired = _tokenExpired(
                session.refreshToken.token, session.refreshToken.expiredAt);
            if (expired) {
              await _createUserSession(user.uniqueKey, user.userId);
            } else {
              refreshOrCreate(user, session.refreshToken.token);
            }
          }
        }
      }
    }
  }

  Future<void> refreshOrCreate(UserEntity user, refreshToken) async {
    _sessionApi.refreshSession(refreshToken).then((newSession) async {
      await _sessionRepo.insert(newSession.toEntity(user.userId));
      await _analytics.reportUserTokenRefresh(user.userId);
    }).catchError((e) async {
      await _createUserSession(user.uniqueKey, user.userId);
    });
  }

  bool _tokenExpired(String token, String expiredAt) {
    return DateTime.parse(expiredAt).isBefore(DateTime.now());
  }

  Future<void> _createUserSession(String uniqueKey, int userId) async {
    final newSession = await _sessionApi.userKeyLogin(uniqueKey);
    await _sessionRepo.insert(newSession.toEntity(userId));
    await _analytics.reportUserLoginWIthStaticKey(userId);
  }

  void start(Stream<bool> userSessionController) {
    userSessionController.listen((event) {
      createUser(forceRefresh: true);
    });
  }
}
