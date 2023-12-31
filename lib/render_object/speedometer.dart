import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SpeedoMeterScreen extends StatelessWidget {
  const SpeedoMeterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 37, 37),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: CustomSlider(
            speedometerColor: Colors.cyan,
          ),
        ),
      ),
    );
  }
}

const int numOfPoints = 30;
const unitArc = 180 / numOfPoints;

class CustomSlider extends LeafRenderObjectWidget {
  const CustomSlider({super.key, required this.speedometerColor});
  final MaterialColor speedometerColor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomSlider(
      color: speedometerColor,
    );
  }
}

class RenderCustomSlider extends RenderAligningShiftedBox with MathMixin {
  RenderCustomSlider({required color})
      : super(textDirection: TextDirection.ltr, alignment: Alignment.center) {
    dragGestureRecognizer = PanGestureRecognizer()
      ..onStart = _dragStart
      ..onEnd = _dragEnd
      ..onUpdate = _dragUpdate;
    tapGestureRecognizer = TapGestureRecognizer()..onTapDown = _tapDown;
    _color = color;
  }

  MaterialColor? _color;
  Path _trackerPath = Path();
  late final DragGestureRecognizer dragGestureRecognizer;
  late final TapGestureRecognizer tapGestureRecognizer;
  double pointerPoint = numOfPoints / 2;
  Offset knobPosition = const Offset(0, 0);

  MaterialColor? get color => _color;
  set color(MaterialColor? color) {
    if (_color == color) return;
    _color = color;
    markNeedsLayout();
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final size = min(constraints.maxHeight, constraints.maxWidth);
    return Size(size, size);
  }

  @override
  bool get sizedByParent => true;

  @override
  double computeMinIntrinsicHeight(double width) {
    return min(width, size.height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return min(height, size.width);
  }

  @override
  bool hitTestSelf(Offset position) {
    var radius = (size.width / 2);
    position = position.translate(-radius, -(size.height / 2));
    return _trackerPath.contains(position);
  }

  @override
  void handleEvent(
      PointerEvent event, covariant HitTestEntry<HitTestTarget> entry) {
    if (event is PointerDownEvent) {
      tapGestureRecognizer.addPointer(event);
      dragGestureRecognizer.addPointer(event);
    }
  }

  void _dragStart(DragStartDetails details) {}
  void _dragEnd(DragEndDetails details) {}
  void _dragUpdate(DragUpdateDetails details) {
    final position = details.localPosition;
    if (_notWithinBound(position)) return;
    _updateKnobAndPointerPosition(position);
    markNeedsLayout();
  }

  void _tapDown(TapDownDetails details) {
    if (_notWithinBound(details.localPosition)) return;
    _updateKnobAndPointerPosition(details.localPosition);
    markNeedsLayout();
  }

  bool _notWithinBound(Offset position) =>
      position.dx > size.width || position.dy < 0;

  _updateKnobAndPointerPosition(Offset position) {
    knobPosition = position.translate(-(size.width / 2), -(size.height / 2));
    pointerPoint = pointFromRadius(position.dx);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final radius = (size.width / 2);
    context.pushClipRect(needsCompositing, offset, Offset.zero & size,
        (context, offset) {
      final canvas = context.canvas;
      canvas.translate(
          (size.width / 2) + offset.dx, (size.height / 2) + offset.dy);
      _drawSpeedometerTicks(canvas, offset, unitArc, radius);
      _drawPointer(radius, canvas);
      _drawSlider(canvas);
    });
  }

  void _drawSlider(Canvas canvas) {
    var curveRadius = const Radius.circular(30);
    final topMargin = size.height * 0.2;
    var radius = size.width / 2;
    _trackerPath = _trackerPath
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromPoints(
              Offset(-radius, topMargin + 10), Offset(radius, topMargin)),
          topLeft: curveRadius,
          topRight: curveRadius,
          bottomLeft: curveRadius,
          bottomRight: curveRadius,
        ),
      );
    final colorRatio = colorWithRatio(pointerPoint, majorColor: _color);
    canvas.drawPath(
        _trackerPath,
        Paint()
          ..shader = LinearGradient(
            colors: colorRatio.colors,
            stops: colorRatio.ratio,
          ).createShader(Rect.fromCenter(
              center: const Offset(0, 0),
              width: size.width,
              height: size.height))
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
    canvas.drawCircle(
        Offset(knobPosition.dx, topMargin + 5),
        20,
        Paint()
          ..color = Colors.blueGrey[500]!
          ..strokeWidth = 5);
    canvas.drawCircle(Offset(knobPosition.dx, topMargin + 5), 15,
        Paint()..color = Colors.amber);
  }

  void _drawPointer(double radius, Canvas canvas) {
    final pointerAngle = unitArc * pointerPoint;
    final paint = Paint()
      ..color = Colors.blueGrey[500]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final Offset startPosition = Offset(
        computeHorizontalPoint(pointerAngle, radius - 20),
        computeVerticalPoint(pointerAngle, radius - 20));
    const Offset endPosition = Offset(0, 0);
    canvas.drawLine(startPosition, endPosition, paint);

    canvas.drawCircle(
      const Offset(0, 0),
      15,
      Paint()
        ..color = Colors.blueGrey[500]!
        ..strokeWidth = 5,
    );
    canvas.drawCircle(
        const Offset(0, 0),
        8,
        Paint()
          ..color = Colors.amber
          ..strokeWidth = 5);
  }

  void _drawSpeedometerTicks(
      Canvas canvas, Offset offset, double unitArc, double radius) {
    for (int i = 0; i < numOfPoints + 1; i++) {
      final sectorLength = (unitArc * i);
      final tickLength = (size.width) * (i % 5 == 0 ? 0.15 : 0.08);

      final Offset startPosition = Offset(
          computeHorizontalPoint(sectorLength, radius - tickLength),
          computeVerticalPoint(sectorLength, radius - tickLength));

      final Offset endPosition = Offset(
        computeHorizontalPoint(sectorLength, radius),
        computeVerticalPoint(sectorLength, radius),
      );

      final colorRatio = colorWithRatio(pointerPoint, majorColor: _color);
      canvas.drawLine(
          endPosition,
          startPosition,
          Paint()
            ..shader = SweepGradient(
                    colors: colorRatio.colors,
                    stops: colorRatio.ratio,
                    endAngle: 2 * pi,
                    startAngle: pi,
                    tileMode: TileMode.mirror)
                .createShader(
                    Rect.fromCircle(center: const Offset(0, 0), radius: radius))
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4);
    }
  }
}

mixin MathMixin {
  double pointFromRadius(double radius) {
    return (pi / numOfPoints) * radius;
  }

  double computeVerticalPoint(double sectorLength, double radius) {
    final angle = convertToRadian(sectorLength + 90);
    return radius * cos(angle);
  }

  double computeHorizontalPoint(double sectorLength, double radius) {
    final angle = convertToRadian(sectorLength + 90);
    return -radius * sin(angle);
  }

  convertToRadian(double degree) {
    return degree * pi / 180;
  }

  double interpolate(
      {required double start, required double end, int index = 1}) {
    return ((start + end) - end) * index;
  }

  double ratio(double value) => value / numOfPoints;

  ColorsRatio colorWithRatio(double value, {MaterialColor? majorColor}) {
    return ColorsRatio(
        colors: List.generate(numOfPoints, (index) {
          final indexRatio = ratio(index.toDouble());
          bool isPassedPoint = value >= index;
          majorColor = majorColor ?? Colors.purple;

          Color color = majorColor!;
          const startRatio = 7 / numOfPoints;
          const midRatio = 20 / numOfPoints;
          const endRatio = 25 / numOfPoints;

          if (indexRatio <= startRatio) {
            color = majorColor![300]!;
          } else if (indexRatio > startRatio && indexRatio <= midRatio) {
            color = majorColor![400]!;
          } else {
            color = majorColor![900]!;
          }
          return isPassedPoint ? color : Colors.grey;
        }),
        ratio: List<double>.generate(
            numOfPoints, (index) => ratio(index.toDouble())).toList());
  }

  int colorLength(List<Color> colors) {
    return colors.length;
  }
}

class ColorsRatio {
  final List<Color> colors;
  final List<double> ratio;

  ColorsRatio({required this.colors, required this.ratio});
}
