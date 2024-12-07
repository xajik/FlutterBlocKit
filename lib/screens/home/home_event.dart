abstract class ConnectivityEvent {}

class CheckConnectionEvent extends ConnectivityEvent {}

class ConnectionChangedEvent extends ConnectivityEvent {
  final bool isConnected;

  ConnectionChangedEvent(this.isConnected);
}

abstract class HomeUserSessionEvent {}

class HomeUserSessionInitEvent extends HomeUserSessionEvent {}

abstract class HomeActionEvent {}

class HomeInitEvent extends HomeActionEvent {}

class HomeLoadEvent extends HomeActionEvent {}
