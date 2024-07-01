import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  final index;
  PathPainter(this.index);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    var path = Path();

    if (index == 0) {
      path.lineTo(size.width / 2 - 40, 0);
      path.cubicTo(size.width / 2 - 10, size.height / 9, size.width / 2 - 30, size.height / 1, size.width / 2 + 10, size.height - 2);
      path.lineTo(size.width, size.height - 2);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(size.width, 0);
      path.lineTo(size.width / 2 + 40, 0);
      path.cubicTo(size.width / 2 + 10, size.height / 9, size.width / 2 + 30, size.height / 1, size.width / 2 - 10, size.height - 2);
      path.lineTo(0, size.height - 2);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
