import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'app_analytics.dart';

import '../../firebase_options.dart' as firebase;

class FirebaseService extends AppAnalyticsProvider {
  final FirebaseAnalytics _analytics;
  final FirebaseAnalyticsObserver _observer;
  get observer => _observer;

  FirebaseService._(
    this._analytics,
    this._observer,
  );

  static Future<FirebaseService> create() async {
    final app = await Firebase.initializeApp(
        options: firebase.DefaultFirebaseOptions.currentPlatform);
    final analytics = FirebaseAnalytics.instanceFor(app: app);
    final observer = FirebaseAnalyticsObserver(analytics: analytics);
    analytics.setAnalyticsCollectionEnabled(kReleaseMode);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    final service = FirebaseService._(analytics, observer);
    return service;
  }

  @override
  @override
  Future<void> track(String event, {Map<String, dynamic>? args}) async {
    _analytics.logEvent(name: event, parameters: args);
  }

  //User

  Future<void> setUserId(int userId) async {
    await _analytics.setUserId(id: userId.toString());
  }

  // Crashlitics

  void nonFatal(dynamic exception, {StackTrace? stack}) {
    FirebaseCrashlytics.instance.recordError(exception, stack);
  }
}
