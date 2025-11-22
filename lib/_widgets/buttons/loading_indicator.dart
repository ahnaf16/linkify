import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.size, this.strokeWidth, this.indicatorColor}) : _onPrimary = false;
  const LoadingIndicator.onPrimary({super.key, this.size, this.strokeWidth}) : _onPrimary = true, indicatorColor = null;

  final bool _onPrimary;
  final double? size;
  final double? strokeWidth;

  /// if not null, this will override the default color
  final Color? indicatorColor;

  @override
  Widget build(BuildContext context) {
    final color = indicatorColor ?? (_onPrimary ? context.colors.onPrimary : context.colors.primary);
    if (context.isIos) return CupertinoActivityIndicator(color: color);

    return SizedBox.square(
      dimension: size ?? 20,
      child: CircularProgressIndicator(color: color, strokeWidth: 2),
    );
  }
}

class LoadingBuilder extends StatelessWidget {
  const LoadingBuilder({super.key, this.size, required this.isLoading, this.color, this.strokeWidth, this.child});

  final bool isLoading;
  final Color? color;
  final Widget? child;
  final double? size;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingIndicator(size: size, strokeWidth: strokeWidth, indicatorColor: color);
    }
    return child ?? const SizedBox.shrink();
  }
}
