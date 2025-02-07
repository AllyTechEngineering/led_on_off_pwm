import 'package:flutter/material.dart';

class RectangularSliderThumbShape extends SliderComponentShape {
  final double thumbWidth;
  final double thumbHeight;

  const RectangularSliderThumbShape({
    this.thumbWidth = 20.0, // Width of the thumb in horizontal orientation
    this.thumbHeight = 35.0, // Height of the thumb in horizontal orientation
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbWidth, thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final Paint paint =
        Paint()
          ..color = sliderTheme.thumbColor ?? Colors.grey
          ..style = PaintingStyle.fill;

    final Rect thumbRect = Rect.fromCenter(
      center: center,
      width: thumbWidth,
      height: thumbHeight,
    );

    canvas.drawRect(thumbRect, paint);
  }
}