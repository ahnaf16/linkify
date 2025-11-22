import 'dart:async';
import 'dart:ui';

class Debouncer {
  Debouncer({required this.delay});

  final Duration delay;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() => _timer?.cancel();
}

class Throttler {
  Throttler(this.interval);
  final Duration interval;

  VoidCallback? _action;
  Timer? _timer;

  void call(VoidCallback action, {bool immediateCall = false}) {
    _action = action;
    if (_timer == null) {
      if (immediateCall) {
        _action?.call();
        _action = null;
      }
      _timer = Timer(interval, () {
        _action?.call();
        _action = null;
        _timer = null;
      });
    }
  }

  void cancelPending() {
    _action = null;
    _timer?.cancel();
    _timer = null;
  }
}
