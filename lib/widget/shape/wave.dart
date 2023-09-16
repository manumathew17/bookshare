import 'dart:math';
import 'package:flutter/cupertino.dart';

class WavePainter extends CustomPainter {
  final Color color;
  final double amplitude;
  final double frequency;
  final double yOffset;

  WavePainter({
    required this.color,
    required this.amplitude,
    required this.frequency,
    this.yOffset = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);

    for (var i = 0; i < size.width; i++) {
      final x = i.toDouble();
      final y = size.height +
          amplitude * (sin((x / size.width * frequency * 2 * pi) + yOffset));
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



