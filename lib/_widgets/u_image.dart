import 'dart:io';

import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';
import 'package:universal_image/universal_image.dart';

class UImage extends StatelessWidget {
  const UImage(
    this.src, {
    super.key,
    this.height,
    this.width,
    this.dimension,
    this.fit = BoxFit.cover,
    this.onImgTap,
    this.borderRadius,
    this.isAvatar = false,
    this.iconSize,
    this.color,
    this.colorBlendMode,
    this.backgroundColor,
  });

  /// Image source, it can be
  /// - `http url`,
  /// - `assets file path` (assets path must start with `assets`),
  /// - `local file path`
  /// - `icon data`
  /// - `Base64 string`
  /// - `Uint8List`
  final Object src;

  final double? height;
  final double? width;

  /// if not null then height and width are ignored
  final double? dimension;
  final double? iconSize;
  final BoxFit fit;
  final void Function()? onImgTap;
  final bool isAvatar;
  final double? borderRadius;

  /// An optional `Color` property that sets the color of the image.
  final Color? color;

  /// An optional `BlendMode` property that defines how the image color should blend with the background.
  final BlendMode? colorBlendMode;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius ?? Corners.sm);

    final double? h = dimension ?? height;
    final double? w = dimension ?? width;
    final size = iconSize ?? dimension ?? h ?? w;

    dynamic source = src;

    if (src case final File file) source = file.path;

    return InkWell(
      borderRadius: radius,
      hoverColor: Colors.transparent,
      onTap: onImgTap,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(borderRadius: radius, color: backgroundColor ?? context.colors.outline),
        clipBehavior: Clip.hardEdge,
        child: UniversalImage(
          source,
          width: w,
          height: h,
          size: size,
          fit: fit,
          placeholder: const Center(child: LoadingIndicator()),
          errorPlaceholder: Center(
            child: Icon(
              isAvatar ? Icons.person_outline : Icons.hide_image_outlined,
              color: isAvatar ? context.colors.primary : null,
            ),
          ),
        ),
      ),
    );
  }
}

class PhotoView extends StatelessWidget {
  const PhotoView(this.image, {super.key});

  final Object image;

  static void open(BuildContext context, Object image) {
    context.nPush(PhotoView(image), fullScreen: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: KHero(
          tag: image.toString(),
          child: UImage(image, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class PhotoViewWrapper extends StatelessWidget {
  const PhotoViewWrapper({super.key, required this.image, required this.child});

  final Object image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KHero(
      tag: image.toString(),
      child: GestureDetector(onTap: () => PhotoView.open(context, image), child: child),
    );
  }
}
