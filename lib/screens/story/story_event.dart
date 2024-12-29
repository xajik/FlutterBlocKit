abstract class StoryEvent {}

class StoryLoadEvent extends StoryEvent {
  final String postUrl;

  StoryLoadEvent(this.postUrl);
  
}
