import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';

class SubmitButton extends HookWidget {
  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.height,
    this.width,
    this.padding,
    this.style,
    this.isEnable = true,
    this.dense = false,
    this.useGradient = true,
  });

  final Function(ValueNotifier<bool> isLoading)? onPressed;

  final Widget child;
  final Widget? icon;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? style;
  final bool dense;
  final bool isEnable;
  final bool useGradient;

  FilledButton _buttonMat(BuildContext context, ButtonStyle style, ValueNotifier<bool> isLoading) {
    return FilledButton.icon(
      style: style,
      onPressed: !isEnable
          ? null
          : () {
              try {
                if (isLoading.value) return;
                onPressed?.call(isLoading);
              } catch (e, s) {
                catErr('SubmitButton', e, s);
                isLoading.value = false;
              }
            },
      label: icon == null ? (isLoading.value ? loadingWidget(context) : child) : child,
      icon: icon == null ? null : (isLoading.value ? loadingWidget(context) : icon!),
    );
  }

  static Widget loadingWidget(BuildContext context) {
    if (context.isIos) {
      return CupertinoActivityIndicator(color: context.colors.surface);
    }
    return SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(color: context.colors.surface, strokeWidth: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final ButtonStyle buttonStyle = style ?? FilledButton.styleFrom();

    return SafeArea(
      top: false,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: SizedBox(
          height: height ?? (dense ? 50 : 50),
          width: width ?? (dense ? null : double.infinity),
          child: _buttonMat(context, buttonStyle, isLoading),
        ),
      ),
    );
  }
}
