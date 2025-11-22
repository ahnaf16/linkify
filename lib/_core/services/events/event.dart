import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:linkify/main.export.dart';

class EvBus {
  EvBus._internal();

  static final EvBus instance = EvBus._internal();

  final _eventBus = EventBus();

  final _throttler = Throttler(3.seconds);

  void fire(AppEvent event) {
    _eventBus.fire(event);
    cat('event fired: ${event.runtimeType}', 'EvBus.fire');
  }

  void dispose() {
    _throttler.cancelPending();
    _eventBus.destroy();
  }

  Stream<T> onEvent<T extends AppEvent>() => _eventBus.on<T>();

  //! logout
  void fireLogoutEv([String? reason]) => _eventBus.fire(LoggedOutEv(reason));

  Stream<LoggedOutEv> onLogoutEv() => onEvent<LoggedOutEv>();
}
