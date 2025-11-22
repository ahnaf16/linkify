import 'package:flutter/material.dart';

/// Keyboard state
enum KeyboardVisibilityState {
  visible,
  hidden;

  bool get isVisible => this == KeyboardVisibilityState.visible;
  bool get isHidden => this == KeyboardVisibilityState.hidden;
}

/// Callback type for keyboard state change
typedef OnKeyboardStateChanged = void Function(KeyboardVisibilityState state);

/// Builder function that receives the current keyboard state
typedef KeyboardVisibilityBuilder = Widget Function(BuildContext context, KeyboardVisibilityState state);

/// A widget that listens for keyboard visibility changes.
///
/// Can be used either with:
/// - `child` + `onKeyboardStateChanged`, or
/// - `builder` that rebuilds when keyboard visibility changes.
class KeyboardVisibility extends StatefulWidget {
  const KeyboardVisibility({super.key, required this.child, required this.onKeyboardStateChanged})
    : builder = null,
      assert(child != null && onKeyboardStateChanged != null);

  const KeyboardVisibility.builder({super.key, required this.builder}) : child = null, onKeyboardStateChanged = null;

  final Widget? child;
  final OnKeyboardStateChanged? onKeyboardStateChanged;
  final KeyboardVisibilityBuilder? builder;

  @override
  State<KeyboardVisibility> createState() => _KeyboardVisibilityState();
}

class _KeyboardVisibilityState extends State<KeyboardVisibility> with WidgetsBindingObserver {
  KeyboardVisibilityState _state = KeyboardVisibilityState.hidden;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _updateState();
  }

  void _updateState() {
    final bottomInset = WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom;
    final newState = bottomInset > 0 ? KeyboardVisibilityState.visible : KeyboardVisibilityState.hidden;

    if (_state != newState) {
      _state = newState;
      widget.onKeyboardStateChanged?.call(_state);
      if (widget.builder != null && mounted) {
        setState(() {}); // rebuild builder version
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builder != null) {
      return widget.builder!(context, _state);
    }
    return widget.child!;
  }
}
