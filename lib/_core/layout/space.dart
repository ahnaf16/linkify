import 'package:flutter/material.dart';

/// Default durations for animations
class Insets {
  const Insets._();

  /// 4 px
  static const double xs = 4;

  /// 8 px
  static const double sm = 8;

  /// 12 px
  static const double med = 12;

  /// 16 px
  static const double lg = 16;

  /// 24 px
  static const double xl = 24;

  /// 32 px
  static const double xxl = 32;

  /// 48 px
  static const double xxxl = 48;

  /// 64 px
  static const double offset = 64;
}

class Pads {
  const Pads._();

  /// l = left, r = right, t = top, b = bottom
  static EdgeInsets _build(String dir, double pad) {
    return EdgeInsets.only(
      left: dir.contains('l') ? pad : 0,
      right: dir.contains('r') ? pad : 0,
      top: dir.contains('t') ? pad : 0,
      bottom: dir.contains('b') ? pad : 0,
    );
  }

  /// 4 px
  static EdgeInsets xs([String dir = 'ltrb']) => _build(dir, Insets.xs);

  /// 8 px
  static EdgeInsets sm([String dir = 'ltrb']) => _build(dir, Insets.sm);

  /// 12 px
  static EdgeInsets med([String dir = 'ltrb']) => _build(dir, Insets.med);

  /// 16 px
  static EdgeInsets lg([String dir = 'ltrb']) => _build(dir, Insets.lg);

  /// 24 px
  static EdgeInsets xl([String dir = 'ltrb']) => _build(dir, Insets.xl);

  /// 32 px
  static EdgeInsets xxl([String dir = 'ltrb']) => _build(dir, Insets.xxl);

  /// 48 px
  static EdgeInsets xxxl([String dir = 'ltrb']) => _build(dir, Insets.xxxl);

  static const EdgeInsets zero = EdgeInsets.only();
  static EdgeInsets all(double value) => EdgeInsets.all(value);
  static EdgeInsets sym([double h = 0, double v = 0]) => EdgeInsets.symmetric(horizontal: h, vertical: v);

  /// Creates padding with flexible shorthand:
  /// - [all] sets all sides
  /// - [h] sets left & right
  /// - [v] sets top & bottom
  /// - Individual sides override shorthands
  static EdgeInsets only({
    double all = 0,
    double? h,
    double? v,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return EdgeInsets.only(
      top: top ?? v ?? all,
      bottom: bottom ?? v ?? all,
      left: left ?? h ?? all,
      right: right ?? h ?? all,
    );
  }
}
