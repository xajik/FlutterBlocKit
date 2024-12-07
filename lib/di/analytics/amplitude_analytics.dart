import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/widgets.dart';

import 'app_analytics.dart';

const _amplitudeAppKey = "TODO: Update";

class AmplitudeService extends AppAnalyticsProvider {
  final Amplitude _analytics;

  AmplitudeService._(this._analytics);

  static Future<AmplitudeService> create() async {
    final Amplitude analytics = Amplitude.getInstance();
    await analytics.init(_amplitudeAppKey);
    return  AmplitudeService._(analytics);
  }

  Future<void> setUserId(String userId) async {
    await _analytics.setUserId(userId);
  }

  Future<void> setDeviceId(String deviceId) async {
    await _analytics.setDeviceId(deviceId);
  }

  @override
  Future<void> track(
    String event, {
    Map<String, dynamic>? args,
  }) async {
    await _analytics.logEvent(
      event,
      eventProperties: args,
    );
  }

  Future<void> screen(
    String action,
    String screenName,
  ) async {
    _analytics
        .logEvent('screen_$action', eventProperties: {'screen': screenName});
  }
}

class AmplitudeNavigatorObserver extends RouteObserver<ModalRoute<dynamic>> {
  final AmplitudeService _amplitude;

  AmplitudeNavigatorObserver(this._amplitude);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logScreenChange(route, 'push');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logScreenChange(route, 'pop');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logScreenChange(newRoute, 'replace');
  }

  void _logScreenChange(Route? route, String action) {
    final screenName = route?.settings.name ?? 'Unknown';
    _amplitude.screen(action, screenName);
  }
}
