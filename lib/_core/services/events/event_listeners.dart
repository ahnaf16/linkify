import 'package:linkify/main.export.dart';

final loggedOutEvProvider = StreamProvider<LoggedOutEv>((ref) async* {
  yield* EvBus.instance.onLogoutEv();
});
