import 'package:flutterblockit/di/db/entity/post_entity.dart';
import 'package:flutterblockit/utils/data_snapshot.dart';

abstract class StoryScreenState {
  StoryScreenState();
}

class StoryInitScreenState extends StoryScreenState {
  StoryInitScreenState();
}

class StoryLoadedScreenState extends StoryScreenState {
  final DataSnapshot<PostEntity> story;
  StoryLoadedScreenState(this.story);
}