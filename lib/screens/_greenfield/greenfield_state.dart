abstract class GreenfieldScreenState {
  final int currentValue;
  GreenfieldScreenState(this.currentValue);
}

class CounterUpdated extends GreenfieldScreenState {
  CounterUpdated(super.counterValue);
}