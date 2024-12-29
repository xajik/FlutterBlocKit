import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'story_bloc.dart';
import 'story_event.dart';
import 'story_localization.dart';
import 'story_state.dart';

import '/utils/context_utils.dart';

class StoryScreen extends StatelessWidget {

  static const route = "/story";

  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = StoryLocalization(context.appLocalizations());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(localization.appName),
      ),
      body: BlocProvider(
        create: (context) => StoryBloc(),
        child: BlocBuilder<StoryBloc, StoryScreenState>(
          builder: (context, state) {
            final counterValue = state.currentValue;
        
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    localization.counterMessage,
                  ),
                  Text(
                    '$counterValue',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<StoryBloc>().add(StoryIncrementCounter());
        },
        tooltip: localization.incrementTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }
}