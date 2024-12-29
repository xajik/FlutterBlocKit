import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblockit/di/usecase/posts_use_case.dart';
import 'package:flutterblockit/utils/data_snapshot.dart';

import 'story_event.dart';
import 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryScreenState> {
  final PostsUseCase _postsUseCase;

  StoryBloc(this._postsUseCase) : super(StoryInitScreenState()) {
    on<StoryLoadEvent>((event, emit) async {
      try {
        final data = await _postsUseCase.getByUrl(event.postUrl);
        emit(StoryLoadedScreenState(data));
      } catch (error) {
        emit(StoryLoadedScreenState(DataSnapshot.error(error.toString())));
      }
    });
  }
}
