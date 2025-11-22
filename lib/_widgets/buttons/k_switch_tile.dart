import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';

class KSwitchTile extends StatelessWidget {
  const KSwitchTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.leading,
  });
  final String title;
  final String? subtitle;
  final bool value;
  final dynamic Function(bool value)? onChanged;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged?.call(!value),
      child: DecoContainer(
        color: context.colors.surface.op2,
        borderRadius: Corners.lg,
        padding: Pads.sym(10, 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) leading!,
            const Gap(Insets.med),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.text.bodyLarge!.op(.8)),
                  if (subtitle != null)
                    Text(subtitle!, style: context.text.bodyMedium!.copyWith(color: context.colors.outline)),
                ],
              ),
            ),
            Transform.scale(
              scale: 0.75,
              child: Switch.adaptive(value: value, onChanged: onChanged),
            ),
          ],
        ),
      ),
    );
  }
}
