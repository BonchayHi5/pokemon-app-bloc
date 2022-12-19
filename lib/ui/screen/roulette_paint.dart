import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

const ORANGE_NORMAL = Color(0xffff871f);
const GREY_NORMAL = Color(0xffa8aaac);
const LIGHT_GREEN_NORMAL = Color(0xff4ffff6);

class PieStyle {
  final Color dividerColor;
  final double dividerThickness;
  PieStyle({
    required this.dividerColor,
    required this.dividerThickness,
  });
}

class PieGroup {
  final double radius;
  final double weight;
  final Color color;
  PieGroup({
    required this.radius,
    required this.weight,
    required this.color,
  });
}

class RoulettePaint extends StatelessWidget {
  const RoulettePaint({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: _CustomRoulettePainter(
          style: PieStyle(
            dividerColor: Colors.black,
            dividerThickness: 0.1,
          ),
          group: List.generate(
            36,
            (index) => PieGroup(
              weight: 1,
              color: index == 0 || index == 10
                  ? LIGHT_GREEN_NORMAL
                  : index == 20 || index == 30
                      ? ORANGE_NORMAL
                      : GREY_NORMAL,
              radius: Random().nextDouble() * 90,
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomRoulettePainter extends CustomPainter {
  _CustomRoulettePainter({
    required this.style,
    required this.group,
  });

  final PieStyle style;
  final List<PieGroup> group;
  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: Offset.zero, radius: radius);
    double initialRotation = 0.04;

    canvas.translate(size.width / 2, size.height / 2);
    canvas.save();
    canvas.rotate(-pi / 2 + initialRotation);
    _drawBackground(canvas, radius, rect);
    canvas.restore();
  }

  _drawBackground(Canvas canvas, double radius, Rect rect) {
    _paint.strokeWidth = 0;
    _paint.style = ui.PaintingStyle.fill;
    double drewSweep = 0;
    for (var i = 0; i < group.length; i++) {
      final unit = group[i];
      final sweep = 2 * pi * unit.weight / group.length;

      canvas.save();
      canvas.rotate(drewSweep);

      // Draw the section background
      _paint.color = unit.color;
      _paint.strokeWidth = 0;
      _paint.style = ui.PaintingStyle.fill;

      //draw each unit size
      canvas.drawArc(
        Rect.fromCircle(center: Offset.zero, radius: unit.radius),
        0.0 * i,
        sweep,
        true,
        _paint,
      );
      // Draw the section border
      _paint.color = style.dividerColor;
      _paint.strokeWidth = style.dividerThickness;
      _paint.style = ui.PaintingStyle.stroke;

      //draw border
      canvas.drawArc(rect, 0.0 * i, sweep, true, _paint);
      canvas.restore();

      drewSweep += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _CustomRoulettePainter oldDelegate) =>
      oldDelegate.group != group || oldDelegate.style != style;
}
