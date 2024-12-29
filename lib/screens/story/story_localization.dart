import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoryLocalization {
  final AppLocalizations localizations;

  StoryLocalization(this.localizations);

  String get appName => localizations.appName;
  String get counterMessage => localizations.counterMessage;
  String get incrementTooltip => localizations.incrementTooltip;
}
