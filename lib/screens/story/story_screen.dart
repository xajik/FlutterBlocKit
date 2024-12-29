import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutterblockit/screens/story/story_event.dart';

import 'story_bloc.dart';
import 'story_localization.dart';
import 'story_state.dart';

import '/utils/context_utils.dart';

class StoryScreen extends StatelessWidget {
  static const route = "/story";
  static const paramUrl = "url";

  final String _postUrl;

  StoryScreen({super.key, required Map<String, dynamic> arguments})
      : _postUrl = arguments[paramUrl];

  @override
  Widget build(BuildContext context) {
    final localization = StoryLocalization(context.appLocalizations());
    return BlocProvider(
      create: (context) =>
          StoryBloc(context.read())..add(StoryLoadEvent(_postUrl)),
      child:
          BlocBuilder<StoryBloc, StoryScreenState>(builder: (context, state) {
        var title = localization.loading;
        Widget body = const Center(child: CircularProgressIndicator());

        if (state is StoryLoadedScreenState) {
          final data = state.story.data;
          if (data != null) {
            title = data.title;
            body = SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: HtmlWidget(
                data.content,
                enableCaching: true,
              ),
            );
          } else if (state.story.failed) {
            title = localization.error;
            body = Center(child: Text(localization.oops));
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: body,
        );
      }),
    );
  }
}
