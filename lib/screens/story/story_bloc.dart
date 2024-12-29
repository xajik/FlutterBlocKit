import 'package:flutter_bloc/flutter_bloc.dart';

import 'story_event.dart';
import 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryScreenState> {
  StoryBloc() : super(CounterUpdated(0)) {
    on<StoryIncrementCounter>((event, emit) {
      final currentState = state;
      if (currentState is CounterUpdated) {
        final newCounterValue = currentState.currentValue + 1;
        emit(CounterUpdated(newCounterValue));
      }
    });
  }
}
