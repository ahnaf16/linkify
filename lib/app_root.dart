import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';

class AppRoot extends HookConsumerWidget {
  const AppRoot({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return child;
  }
}
