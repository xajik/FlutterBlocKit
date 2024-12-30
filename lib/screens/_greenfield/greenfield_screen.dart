import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'greenfield_bloc.dart';
import 'greenfield_event.dart';
import 'greenfield_localization.dart';
import 'greenfield_state.dart';

import '/utils/context_utils.dart';

class GreenfieldScreenWidget extends StatelessWidget {

  static const route = "/greenfield";

  const GreenfieldScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = GreenfieldLocalization(context.appLocalizations());
    return BlocProvider(
      create: (context) => GreenfieldBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(localization.appName),
        ),
        body: BlocBuilder<GreenfieldBloc, GreenfieldScreenState>(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<GreenfieldBloc>().add(GreenfieldIncrementCounter());
          },
          tooltip: localization.incrementTooltip,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}