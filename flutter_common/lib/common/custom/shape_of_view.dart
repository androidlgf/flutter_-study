import 'package:flutter/material.dart';

export 'package:flutter_common/common/custom/shape/arc.dart';
export 'package:flutter_common/common/custom/shape/circle.dart';
export 'package:flutter_common/common/custom/shape/arc_circle.dart';
export 'package:flutter_common/common/custom/shape/cutcorner.dart';
export 'package:flutter_common/common/custom/shape/diagonal.dart';
export 'package:flutter_common/common/custom/shape/polygon.dart';
export 'package:flutter_common/common/custom/shape/roundrect.dart';
export 'package:flutter_common/common/custom/shape/star.dart';
export 'package:flutter_common/common/custom/shape/triangle.dart';
export 'package:flutter_common/common/custom/shape/bubble.dart';
export 'package:flutter_common/common/custom/shape/custom.dart';

abstract class Shape {
  Path build({Rect rect, double scale});
}

abstract class BorderShape {
  void drawBorder(Canvas canvas, Rect rect);
}

class ShapeOfViewBorder extends ShapeBorder {
  final Shape shape;

  ShapeOfViewBorder({this.shape}) : assert(shape != null);

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(0);
  }

  @override
  ShapeBorder scale(double t) => this;

  /*
  @override
  ShapeBorder lerpFrom(ShapeBorder a, double t) {
    if (a is CircleBorder)
      return CircleBorder(side: BorderSide.lerp(a.side, side, t));
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder lerpTo(ShapeBorder b, double t) {
    if (b is CircleBorder)
      return CircleBorder(side: BorderSide.lerp(side, b.side, t));
    return super.lerpTo(b, t);
  }
  */

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return shape.build(rect: rect, scale: 1);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    if (shape is BorderShape) {
      (shape as BorderShape).drawBorder(canvas, rect);
    }
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final ShapeOfViewBorder typedOther = other;
    return shape == typedOther.shape;
  }

  @override
  int get hashCode => shape.hashCode;

  @override
  String toString() {
    return '$runtimeType($shape)';
  }
}

class ShapeOfView extends StatelessWidget {
  final Widget child;
  final Shape shape;
  final double elevation;
  final Clip clipBehavior;
  final double height;
  final double width;

  ShapeOfView(
      {this.child,
      this.elevation = 4,
      this.shape,
      this.clipBehavior = Clip.antiAlias,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      shape: ShapeOfViewBorder(shape: this.shape),
      clipBehavior: this.clipBehavior,
      elevation: this.elevation,
      child: Container(
        height: this.height,
        width: this.width,
        child: this.child,
      ),
    );
  }
}
