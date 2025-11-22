import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';

class DragHandle extends StatelessWidget {
  const DragHandle({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DecoContainer(
      margin: Pads.only(top: 8, bottom: 12),
      color: color ?? context.colors.outlineVariant,
      height: 7,
      width: 70,
      borderRadius: Corners.circle,
    );
  }
}
