import 'package:flutter_bloc/flutter_bloc.dart';

import 'greenfield_event.dart';
import 'greenfield_state.dart';

class GreenfieldBloc extends Bloc<GreenfieldEvent, GreenfieldScreenState> {
  GreenfieldBloc() : super(GreenfieldCounterUpdated(0)) {
    on<GreenfieldIncrementCounter>((event, emit) {
      final currentState = state;
      if (currentState is GreenfieldCounterUpdated) {
        final newCounterValue = currentState.currentValue + 1;
        emit(GreenfieldCounterUpdated(newCounterValue));
      }
    });
  }
}
