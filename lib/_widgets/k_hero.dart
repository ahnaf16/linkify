import 'package:flutter/material.dart';

class KHero extends StatelessWidget {
  const KHero({required this.child, required this.tag, super.key});

  final Widget child;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(type: MaterialType.transparency, child: child),
    );
  }
}
