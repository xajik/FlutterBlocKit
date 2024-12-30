import 'dart:async';

import 'package:flutterblockit/di/usecase/pages_use_case.dart';
import 'package:flutterblockit/di/usecase/posts_use_case.dart';

import 'api/api_service.dart';
import 'db/db.dart';
import 'usecase/user_session_use_case.dart';
import 'analytics/app_analytics.dart';
import 'analytics/firebase_analytics.dart';
import 'analytics/amplitude_analytics.dart';

class ApplicationDependency {
  final ApiService apiService;
  final Database database;
  final UserSessionUseCase userSessionUsecase;
  final PostsUseCase postsUseCase;
  final PagesUseCase pagesUseCase;
  final AppAnalytics appAnalytics;
  // final FirebaseService firebase; //TODO: Update
  final AmplitudeService amplitude;

  ApplicationDependency({
    required this.apiService,
    required this.database,
    required this.userSessionUsecase,
    required this.postsUseCase,
    required this.pagesUseCase,
    required this.appAnalytics,
    // required this.firebase, //TODO: Update
    required this.amplitude,
  });

  static Future<ApplicationDependency> create() async {
    final StreamController<String?> sessionStream =
        StreamController<String>.broadcast();

    final StreamController<bool> unauthorizedStream =
        StreamController<bool>.broadcast();

    final db = await Database.crete();
    await db.session.sessionStream(sessionStream);


    final api = await ApiServiceFactory.create(
      sessionStream.stream,
      unauthorizedStream,
      db.etag,
    );

    // final firebase = await FirebaseService.create(); //TODO: Update; Create lib/firebase_options.dart via Firebase CLI
    final amplitude = await AmplitudeService.create();
    final analytics = AppAnalyticsImpl([
      amplitude,
      // firebase,  //TODO: Update
    ]);

    final userSession = UserSessionUseCase(
      db.user,
      db.session,
      api.userApi,
      api.sessionApi,
      analytics,
    );

    userSession.start(unauthorizedStream.stream);

    final postsUseCase = PostsUseCase(
      api.postApi,
      db.post,
    );

    final pagesUseCase = PagesUseCase(
      api.postApi,
      db.page,
    );  

    return ApplicationDependency(
      apiService: api,
      database: db,
      userSessionUsecase: userSession,
      postsUseCase: postsUseCase,
      pagesUseCase: pagesUseCase,
      appAnalytics: analytics,
      // firebase: firebase, //TODO: Remove Comment
      amplitude: amplitude,
    );
  }
}
