import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutterblockit/utils/context_utils.dart';

import 'connectivity_bloc.dart';
import 'connectivity_event.dart';
import 'connectivity_localization.dart';
import 'connectivity_state.dart';

class ConnectivityScreen extends StatelessWidget {

  static const route = '/connectivity';

  const ConnectivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localisation = ConnectivityLocalization(context.appLocalizations());

    return BlocProvider(
      create: (context) =>
          ConnectivityBloc(Connectivity())..add(CheckConnectionEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(localisation.appName),
        ),
        body: BlocListener<ConnectivityBloc, ConnectivityState>(
          listener: (context, state) {
            if (state is ConnectivityFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(localisation.appName),
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Center(
            child: Text(localisation.appName),
          ),
        ),
      ),
    );
  }
}
