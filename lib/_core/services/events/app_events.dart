sealed class AppEvent {
  const AppEvent();
}

class LoggedOutEv extends AppEvent {
  const LoggedOutEv([this.reason]);

  final String? reason;
}
