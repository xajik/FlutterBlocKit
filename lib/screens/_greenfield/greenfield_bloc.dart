import 'package:flutter_bloc/flutter_bloc.dart';

import 'greenfield_event.dart';
import 'greenfield_state.dart';

class GreenfieldBloc extends Bloc<GreenfieldEvent, GreenfieldScreenState> {
  GreenfieldBloc() : super(CounterUpdated(0)) {
    on<GreenfieldIncrementCounter>((event, emit) {
      final currentState = state;
      if (currentState is CounterUpdated) {
        final newCounterValue = currentState.currentValue + 1;
        emit(CounterUpdated(newCounterValue));
      }
    });
  }
}
