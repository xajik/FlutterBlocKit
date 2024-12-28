import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeLocalization {
  final AppLocalizations localizations;

  HomeLocalization(this.localizations);

  String get appName => localizations.appName;
  String get author => localizations.author;
  String get oops => localizations.oops;
  String get emptyPosts => localizations.emptyPosts;
  String get noInternetConnection => localizations.noInternetConnection;
}
