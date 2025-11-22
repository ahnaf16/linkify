import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';

extension TextStyleExtensions on TextStyle {
  // Weights
  TextStyle get thin => weight(FontWeight.w100);
  TextStyle get extraLight => weight(FontWeight.w200);
  TextStyle get light => weight(FontWeight.w300);
  TextStyle get regular => weight(FontWeight.normal);
  TextStyle get medium => weight(FontWeight.w500);
  TextStyle get semiBold => weight(FontWeight.w600);
  TextStyle get bold => weight(FontWeight.w700);
  TextStyle get extraBold => weight(FontWeight.w800);
  TextStyle get black => weight(FontWeight.w900);

  /// Shortcut for italic
  TextStyle get italic => style(FontStyle.italic);

  /// Shortcut for underline
  TextStyle get underline => textDecoration(TextDecoration.underline);

  /// Shortcut for lineThrough
  TextStyle get lineThrough => textDecoration(TextDecoration.lineThrough);

  /// Shortcut for overline
  TextStyle get overline => textDecoration(TextDecoration.overline);

  /// Shortcut for color
  TextStyle textColor(Color? v) => copyWithFF(color: v);
  TextStyle get primary => textColor(KColors.primary);
  TextStyle get secondary => textColor(KColors.secondary);
  TextStyle get grey => textColor(KColors.n7);
  TextStyle get onDark => textColor(KColors.textDark);
  TextStyle get onLight => textColor(KColors.textLight);

  TextStyle op(double v) => copyWithFF(color: color?.op(v));

  /// Shortcut for backgroundColor
  TextStyle textBackgroundColor(Color v) => copyWithFF(backgroundColor: v);

  /// Shortcut for fontSize
  TextStyle size(double v) => copyWithFF(fontSize: v);

  /// Scales fontSize up or down
  TextStyle scale(double v) => copyWithFF(fontSize: (fontSize ?? 1) * v);

  /// Shortcut for fontWeight
  TextStyle weight(FontWeight v) => copyWithFF(fontWeight: v);

  /// Shortcut for FontStyle
  TextStyle style(FontStyle v) => copyWithFF(fontStyle: v);

  /// Shortcut for letterSpacing
  TextStyle letterSpace(double v) => copyWithFF(letterSpacing: v);

  /// Shortcut for wordSpacing
  TextStyle wordSpace(double v) => copyWithFF(wordSpacing: v);

  /// Shortcut for textBaseline
  TextStyle baseline(TextBaseline v) => copyWithFF(textBaseline: v);

  /// Shortcut for height
  TextStyle textHeight(double v) => copyWithFF(height: v);

  /// Shortcut for locale
  TextStyle textLocale(Locale v) => copyWithFF(locale: v);

  /// Shortcut for foreground
  TextStyle textForeground(Paint v) => copyWithFF(foreground: v);

  /// Shortcut for background
  TextStyle textBackground(Paint v) => copyWithFF(background: v);

  /// Shortcut for shadows
  TextStyle textShadows(List<Shadow> v) => copyWithFF(shadows: v);

  /// Shortcut for fontFeatures
  TextStyle textFeatures(List<FontFeature> v) => copyWithFF(fontFeatures: v);

  /// Shortcut for decoration
  TextStyle textDecoration(TextDecoration v, {Color? color, TextDecorationStyle? style, double? thickness}) =>
      copyWithFF(decoration: v, decorationColor: color, decorationStyle: style, decorationThickness: thickness);

  /// copy with font family
  TextStyle copyWithFF({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      AppTheme.font(
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        textStyle: this,
      ).copyWith(
        fontVariations: fontVariations,
        inherit: inherit,
        leadingDistribution: leadingDistribution,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );
}
