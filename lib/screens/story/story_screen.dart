import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutterblockit/utils/context_utils.dart';
import 'package:flutterblockit/utils/theme_utils.dart';
import 'story_bloc.dart';
import 'story_event.dart';
import 'story_localization.dart';
import 'story_state.dart';

class StoryScreen extends StatefulWidget {
  static const paramUrl = "url";

  static const route = "story";

  final String _postUrl;

  StoryScreen({super.key, required Map<String, dynamic> arguments})
      : _postUrl = arguments[paramUrl];

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    final localization = StoryLocalization(context.appLocalizations());
    final textTheme = context.textTheme();
    return BlocProvider(
      create: (context) =>
          StoryBloc(context.read())..add(StoryLoadEvent(widget._postUrl)),
      child: BlocBuilder<StoryBloc, StoryScreenState>(
        builder: (context, state) {
          var title = localization.loading;
          Widget body = const Center(child: CircularProgressIndicator());

          if (state is StoryLoadedScreenState) {
            final data = state.story.data;
            if (data != null) {
              title = data.title;
              body = CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200.0,
                    pinned: true,
                    backgroundColor: Colors.white,
                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        // Check if the app bar is collapsed
                        final bool isCollapsed =
                            constraints.biggest.height <= 130.0;

                        return FlexibleSpaceBar(
                          titlePadding: EdgeInsets.only(
                            left: isCollapsed ? 48.0 : 24.0,
                            bottom: 16.0,
                          ),
                          title: Text(
                            title,
                            style: textTheme.headlineSmall,
                            maxLines: isCollapsed ? 1 : 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    'https://igorsteblii.com/${data.image}',
                                fit: BoxFit.cover,
                              ),
                              Container(
                                color: AppColors.white.withOpacity(
                                    0.4), // Overlay for readability
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: HtmlWidget(
                        data.content,
                      ),
                    ),
                  ),
                ],
              );
            } else if (state.story.failed) {
              title = localization.error;
              body = Center(child: Text(localization.oops));
            }
          }

          return Scaffold(
            body: body,
          );
        },
      ),
    );
  }
}
