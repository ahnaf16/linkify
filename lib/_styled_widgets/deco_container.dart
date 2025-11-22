import 'package:flutter/material.dart';

class DecoContainer extends StatelessWidget {
  const DecoContainer({
    super.key,
    this.color,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.borderRadius = 0,
    this.borderRadiusGeo,
    this.width,
    this.height,
    this.child,
    this.ignorePointer = false,
    this.shadows,
    this.clipChild = false,
    this.padding,
    this.alignment,
    this.margin,
    this.gradient,
    this.strokeAlign = BorderSide.strokeAlignInside,
    this.constraints,
    this.shape,
  }) : duration = const Duration(),
       curve = Curves.linear;

  const DecoContainer.animated({
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.linear,
    super.key,
    this.color,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.borderRadius = 0,
    this.borderRadiusGeo,
    this.width,
    this.height,
    this.child,
    this.ignorePointer = false,
    this.shadows,
    this.clipChild = false,
    this.padding,
    this.alignment,
    this.margin,
    this.gradient,
    this.strokeAlign = BorderSide.strokeAlignInside,
    this.constraints,
    this.shape,
  });

  final Alignment? alignment;
  final Color? borderColor;
  final double borderRadius;
  final BorderRadiusGeometry? borderRadiusGeo;
  final double borderWidth;
  final Widget? child;
  final bool clipChild;
  final Color? color;
  final Duration duration;
  final double? height;
  final bool ignorePointer;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadows;
  final double? width;
  final Curve curve;
  final Gradient? gradient;
  final double strokeAlign;
  final BoxConstraints? constraints;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    // Create border if we have both a color and width
    BoxBorder? border;
    if (borderColor != null && borderWidth != 0) {
      border = Border.all(color: borderColor!, width: borderWidth, strokeAlign: strokeAlign);
    }

    BorderRadiusGeometry borderRadius = BorderRadius.circular(this.borderRadius);

    if (borderRadiusGeo != null) borderRadius = borderRadiusGeo!;

    // Create decoration
    final dec = BoxDecoration(
      color: color,
      border: border,
      borderRadius: shape == BoxShape.circle ? null : borderRadius,
      boxShadow: shadows,
      gradient: gradient,
      shape: shape ?? BoxShape.rectangle,
    );

    return IgnorePointer(
      ignoring: ignorePointer,
      child: AnimatedContainer(
        duration: duration,
        curve: curve,
        decoration: dec,
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        alignment: alignment,
        constraints: constraints,
        child: clipChild ? ClipRRect(borderRadius: borderRadius, child: child) : child,
      ),
    );
  }
}
