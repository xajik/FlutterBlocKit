abstract class ConnectivityEvent {}

class CheckConnectionEvent extends ConnectivityEvent {}

class ConnectionChangedEvent extends ConnectivityEvent {
  final bool isConnected;

  ConnectionChangedEvent(this.isConnected);
}