import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblockit/di/usecase/posts_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeActionEvent, HomeState> {
  final PostsUseCase postsUseCase;

  HomeBloc(this.postsUseCase) : super(HomeInitial()) {
    on<HomeLoadEvent>((event, emit) async {
      emit(HomeLoading());
      final posts = await postsUseCase.loadPosts();
      emit(HomeLoaded(posts));
    });
  }
}
