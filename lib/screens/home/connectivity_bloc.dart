import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;

  ConnectivityBloc(this._connectivity) : super(ConnectivityInitial()) {
    _connectivity.onConnectivityChanged.listen((result) {
      final notConnected = result.contains(ConnectivityResult.none) || result.isEmpty;
      add(ConnectionChangedEvent(!notConnected));
    });

    on<ConnectionChangedEvent>((event, emit) {
      if (event.isConnected) {
        emit(ConnectivitySuccess(true));
      } else {
        emit(ConnectivityFailure());
      }
    });

    on<CheckConnectionEvent>((event, emit) async {
      final result = await _connectivity.checkConnectivity();
      final notConnected = result.contains(ConnectivityResult.none) || result.isEmpty;
      add(ConnectionChangedEvent(!notConnected));
    });
  }
}