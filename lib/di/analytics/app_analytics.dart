abstract class AppAnalyticsProvider {
  Future<void> track(
    String event, {
    Map<String, dynamic>? args,
  });
}

abstract class AppAnalytics extends AppAnalyticsProvider {
  Future<void> reportNewUserCreated(dynamic userId);

  Future<void> reportUserTokenRefresh(dynamic userId);

  Future<void> reportUserLoginWIthStaticKey(dynamic userId);
}

class AppAnalyticsImpl extends AppAnalytics {
  final List<AppAnalyticsProvider> _analytics;

  AppAnalyticsImpl(this._analytics);

  @override
  Future<void> track(String event, {Map<String, dynamic>? args}) async {
    for (var element in _analytics) {
      await element.track(event, args: args);
    }
  }

  //User

  @override
  Future<void> reportNewUserCreated(dynamic userId) async {
    await track(
      _Event.newAnnonymousUserCreated,
      args: <String, dynamic>{
        _Param.userId: userId,
      },
    );
  }

  @override
  Future<void> reportUserTokenRefresh(dynamic userId) async {
    await track(
      _Event.annonymousUserTokenRefresh,
      args: <String, dynamic>{
        _Param.userId: userId,
      },
    );
  }

  @override
  Future<void> reportUserLoginWIthStaticKey(dynamic userId) async {
    await track(
      _Event.annonymousUserLoginStaticKey,
      args: <String, dynamic>{
        _Param.userId: userId,
      },
    );
  }

  Future<void> reportUserUpdatedNickname() async {
    await track(_Event.userUpdatedNickname);
  }
}

class _Event {
  static const String newAnnonymousUserCreated = "annonymous_user_created";
  static const String annonymousUserTokenRefresh =
      "annonymous_user_token_refresh";
  static const String annonymousUserLoginStaticKey =
      "annonymous_user_login_static_key";
  static const String userUpdatedNickname = "user_updated_nick_name";
}

class _Param {
  static const String userId = "user_id";
}
