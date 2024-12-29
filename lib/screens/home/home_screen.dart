import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblockit/screens/connectivity/connectivity_bloc.dart';
import 'package:flutterblockit/utils/context_utils.dart';
import 'package:flutterblockit/utils/theme_utils.dart';
import '../connectivity/connectivity_state.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_localization.dart';
import 'home_state.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = HomeLocalization(context.appLocalizations());
    final textTheme = context.textTheme();
    return BlocProvider(
      create: (context) => HomeBloc(context.read())..add(HomeLoadEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.author),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                context.read<HomeBloc>().add(HomeLoadEvent());
              },
            ),
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ConnectivityBloc, ConnectivityState>(
              listener: (context, state) {
                if (state is ConnectivityFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(localization.noInternetConnection),
                      duration: const Duration(seconds: 2),
                      backgroundColor: AppColors.darkGrey,
                    ),
                  );
                }
              },
            ),
            BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is HomeLoaded) {
                  if (state.posts.failed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(localization.oops),
                        duration: const Duration(seconds: 2),
                        backgroundColor: AppColors.darkGrey,
                      ),
                    );
                  }
                }
              },
            ),
          ],
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoaded) {
                if (state.posts.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.posts.failed) {
                  return Center(child: Text(localization.emptyPosts));
                }
                final data = state.posts.data;
                if (data != null && data.isNotEmpty) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final post = data[index];
                      return Card(
                        elevation: 0.4,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            post.title,
                            style: textTheme.titleSmall,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _formatTitle(post.content),
                              style: textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // trailing: const Icon(
                          //   Icons.arrow_forward_ios,
                          //   size: 16,
                          //   color: AppColors.darkGrey,
                          // ),
                          onTap: () {
                            // Handle tap event
                          },
                        ),
                      );
                    },
                  );
                }
              }
              return Center(child: Text(localization.emptyPosts));
            },
          ),
        ),
      ),
    );
  }

  String _formatTitle(String htmlText) {
    final regex = RegExp(r"<[^>]*>");
    final plainText = htmlText.replaceAll(regex, '');
    return plainText;
  }
}
