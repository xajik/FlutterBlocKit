abstract class StoryScreenState {
  final int currentValue;
  StoryScreenState(this.currentValue);
}

class CounterUpdated extends StoryScreenState {
  CounterUpdated(super.counterValue);
}