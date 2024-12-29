import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblockit/di/analytics/amplitude_analytics.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'di/app_di.dart';
import 'screens/_greenfield/greenfield_bloc.dart';
import 'screens/_greenfield/greenfield_screen.dart';
import 'screens/account/account_screen.dart';
import 'screens/connectivity/connectivity_bloc.dart';
import 'screens/connectivity/connectivity_widget.dart';
import 'screens/home/home_screen.dart';
import 'screens/story/story_screen.dart';
import 'utils/theme_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final di = await ApplicationDependency.create();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(createApp(di));
}

Widget createApp(ApplicationDependency di) {
  return MultiRepositoryProvider(
    providers: [
      RepositoryProvider.value(value: di.userSessionUsecase),
      RepositoryProvider.value(value: di.postsUseCase),
      RepositoryProvider.value(value: di.pagesUseCase),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (context) => ConnectivityBloc(Connectivity()),
        ),
        BlocProvider(create: (context) => GreenfieldBloc()),
        // BlocProvider<UserSessionBloc>(
        //   lazy: false,
        //   create: (context) => UserSessionBloc(di.userSessionUsecase)
        //     ..add(HomeUserSessionInitEvent()),
        // ),
      ],
      child: MaterialApp(
        title: 'TODO: Update', //TODO: Update
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.createTheme(),
        home: const HomeScreen(),
        onGenerateRoute: _getRoutes(),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          AmplitudeNavigatorObserver(di.amplitude),
          // di.firebase.observer, //TODO: Update
        ],
      ),
    ),
  );
}

RouteFactory _getRoutes() => (settings) {
      Widget? widget;
      final args = settings.arguments as Map<String, dynamic>?;
      switch (settings.name) {
        case GreenfieldScreenWidget.route:
          widget = const GreenfieldScreenWidget();
          break;
        case ConnectivityScreen.route:
          widget = const ConnectivityScreen();
          break;
        case HomeScreen.route:
          widget = const HomeScreen();
          break;
        case AccountScreen.route:
          widget = const AccountScreen();
          break;
        case StoryScreen.route:
          widget = const StoryScreen();
          break;
      }
      if (widget == null) {
        assert(false, 'Need to implement ${settings.name}');
        return null;
      } else {
        return MaterialPageRoute(
          builder: (context) {
            return widget!;
          },
        );
      }
    };
