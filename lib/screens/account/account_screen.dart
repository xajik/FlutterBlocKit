import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'account_bloc.dart';
import 'account_event.dart';
import 'account_localization.dart';
import 'account_state.dart';

import '/utils/context_utils.dart';

class AccountScreen extends StatelessWidget {
  static const route = "/account";

  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AccountLocalization(context.appLocalizations());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(localization.about),
      ),
      body: BlocProvider(
        create: (context) =>
            AccountBloc(context.read())..add(AccountLoadEvent()),
        child: BlocBuilder<AccountBloc, AccountScreenState>(
          builder: (context, state) {
            if (state is AccountInitialState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccountLoadedScreenState) {
              if (state.page.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.page.failed) {
                return Center(child: Text(localization.oops));
              }
              final data = state.page.data;
              if (data != null) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: HtmlWidget(
                    data.content,
                    enableCaching: true,
                  ),
                );
              }
            }
            return Center(child: Text(localization.oops));
          },
        ),
      ),
    );
  }
}
