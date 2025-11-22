import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';

class OptionChip extends StatelessWidget {
  const OptionChip({
    super.key,
    required this.label,
    this.padding,
    this.color,
    this.onTap,
    this.labelStyle,
    this.borderRadius = 8,
    this.leading,
  });

  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? color;
  final Widget? leading;
  final String label;
  final TextStyle? labelStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.colors.primary;
    return DecoContainer(
      padding: padding ?? Pads.sym(8, 3),
      borderRadius: Corners.lg,
      color: color.op1,
      child: IconTheme(
        data: IconThemeData(color: color, size: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            if (leading != null) DefaultTextStyle(style: context.text.labelSmall!, child: leading!),
            Text(label, style: context.text.labelSmall!.bold.textColor(color).merge(labelStyle)),
          ],
        ),
      ),
    );
  }
}

class RemovableChip<T> extends StatelessWidget {
  const RemovableChip({super.key, required this.text, this.onDelete, required this.value});

  final String text;
  final Function(T value)? onDelete;
  final T value;

  @override
  Widget build(BuildContext context) {
    return DecoContainer(
      borderRadius: Corners.med,
      color: context.colors.primary.op1,
      padding: Pads.sym(10, 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: context.text.labelMedium!.black),
          if (onDelete != null) const Gap(Insets.sm),
          if (onDelete != null)
            InkWell(
              onTap: () => onDelete?.call(value),
              child: Icon(Icons.close_rounded, size: 15, color: context.colors.error),
            ),
        ],
      ),
    );
  }
}
