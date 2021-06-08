import 'package:flutter/material.dart';

class DrawingPainter extends CustomPainter {
  final List<List<Offset>> positions;
  final double strokeWidth;
  final Color strokeColor;

  DrawingPainter({
    this.positions = const [],
    this.strokeWidth = 4.0,
    this.strokeColor = Colors.teal,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);
    canvas.drawColor(Colors.grey[100]!, BlendMode.multiply);

    final paint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..blendMode = BlendMode.srcOver;

    for (List<Offset> points in positions) {
      _paintLine(points, canvas, paint);
    }
  }

  void _paintLine(List<Offset> points, Canvas canvas, Paint paint) {
    final start = points.first;
    final path = Path()..fillType = PathFillType.evenOdd;

    path.moveTo(start.dx, start.dy);

    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(DrawingPainter oldPainter) => true;
}
