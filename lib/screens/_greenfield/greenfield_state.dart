abstract class GreenfieldScreenState {
  final int currentValue;
  GreenfieldScreenState(this.currentValue);
}

class GreenfieldCounterUpdated extends GreenfieldScreenState {
  GreenfieldCounterUpdated(super.counterValue);
}