import 'package:flutter/widgets.dart';
import 'package:linkify/main.export.dart';

class Corners {
  const Corners._();

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

  /// 999
  static const double circle = 999;

  /// 4 px
  static const xsRadius = Radius.circular(xs);

  /// 8 px
  static const smRadius = Radius.circular(sm);

  /// 12 px
  static const mdRadius = Radius.circular(med);

  /// 16 px
  static const lgRadius = Radius.circular(lg);

  /// 24 px
  static const xlRadius = Radius.circular(xl);

  /// 32 px
  static const xxlRadius = Radius.circular(xxl);

  /// 999
  static const circleRadius = Radius.circular(circle);

  /// 4 px
  static const xsBorder = BorderRadius.all(xsRadius);

  /// 8 px
  static const smBorder = BorderRadius.all(smRadius);

  /// 12 px
  static const medBorder = BorderRadius.all(mdRadius);

  /// 16 px
  static const lgBorder = BorderRadius.all(lgRadius);

  /// 24 px
  static const xlBorder = BorderRadius.all(xlRadius);

  /// 32 px
  static const xxlBorder = BorderRadius.all(xxlRadius);

  /// 999
  static const circleBorder = BorderRadius.all(circleRadius);
}

class Rads {
  const Rads._();

  /// tl = topLeft, tr = topRight, bl = bottomLeft, br = bottomRight
  static BorderRadius _build(String dir, double radius) {
    return BorderRadius.only(
      topLeft: dir.low.contains('tl') ? Radius.circular(radius) : Radius.zero,
      topRight: dir.low.contains('tr') ? Radius.circular(radius) : Radius.zero,
      bottomLeft: dir.low.contains('bl') ? Radius.circular(radius) : Radius.zero,
      bottomRight: dir.low.contains('br') ? Radius.circular(radius) : Radius.zero,
    );
  }

  /// 4 px
  static BorderRadius xs([String dir = 'TlTrBlBr']) => _build(dir, Corners.xs);

  /// 8 px
  static BorderRadius sm([String dir = 'TlTrBlBr']) => _build(dir, Corners.sm);

  /// 12 px
  static BorderRadius med([String dir = 'TlTrBlBr']) => _build(dir, Corners.med);

  /// 16 px
  static BorderRadius lg([String dir = 'TlTrBlBr']) => _build(dir, Corners.lg);

  /// 24 px
  static BorderRadius xl([String dir = 'TlTrBlBr']) => _build(dir, Corners.xl);

  /// 32 px
  static BorderRadius xxl([String dir = 'TlTrBlBr']) => _build(dir, Corners.xxl);

  static BorderRadius all(double value) => BorderRadius.all(Radius.circular(value));

  /// Flexible shorthand builder
  static BorderRadius only({
    double all = 0,
    double? left,
    double? right,
    double? top,
    double? bottom,
    double? tl,
    double? tr,
    double? bl,
    double? br,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(tl ?? top ?? left ?? all),
      topRight: Radius.circular(tr ?? top ?? right ?? all),
      bottomLeft: Radius.circular(bl ?? bottom ?? left ?? all),
      bottomRight: Radius.circular(br ?? bottom ?? right ?? all),
    );
  }
}
