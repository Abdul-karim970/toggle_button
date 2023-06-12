import 'dart:math';

import 'package:flutter/material.dart';

class StarsPainter extends CustomPainter {
  int starsColorOpacity;
  StarsPainter({required this.starsColorOpacity});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    Random random = Random();
    var max = 255;

    for (var i = 0; i < 15; i++) {
      final offset = Offset(random.nextInt(width.toInt()).toDouble(),
          random.nextInt(height.toInt()).toDouble());
      final radius = random.nextInt((width * 0.05).toInt()).toDouble();
      canvas.drawCircle(offset, radius,
          Paint()..color = Color.fromARGB(starsColorOpacity, max, max, max));
    }
  }

  @override
  bool shouldRepaint(StarsPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(StarsPainter oldDelegate) => false;
}
