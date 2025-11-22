import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';
import 'package:pull_down_button/pull_down_button.dart';

class PopOver extends StatelessWidget {
  const PopOver({super.key, required this.itemBuilder, required this.buttonBuilder});

  final PullDownMenuItemBuilder itemBuilder;
  final PullDownMenuButtonBuilder buttonBuilder;

  @override
  Widget build(BuildContext context) {
    final isIos = context.theme.platform == TargetPlatform.iOS;

    return Theme(
      data: context.theme.copyWith(
        extensions: [
          if (!isIos)
            PullDownButtonTheme(
              routeTheme: PullDownMenuRouteTheme(
                backgroundColor: ElevationOverlay.applySurfaceTint(
                  context.colors.surface,
                  context.colors.surfaceTint,
                  1,
                ),
              ),
              dividerTheme: PullDownMenuDividerTheme(
                dividerColor: context.colors.outline.op7,
                largeDividerColor: context.colors.outline,
              ),
              itemTheme: PullDownMenuItemTheme(
                destructiveColor: context.colors.error,
                // textStyle: const TextStyle(color: KColor.black),
                // iconActionTextStyle: const TextStyle(color: KColor.black),
                onHoverBackgroundColor: context.colors.primary.op1,
                onHoverTextColor: context.colors.primary,
                onPressedBackgroundColor: context.colors.primary.op3,
              ),
            ),
        ],
      ),
      child: PullDownButton(itemBuilder: itemBuilder, buttonBuilder: buttonBuilder),
    );
  }
}
