import 'dart:math';

import 'package:flutter/material.dart';

class MultiSelectBoundsView extends StatelessWidget {
  const MultiSelectBoundsView({super.key, this.multiSelectBoundsFirst, this.multiSelectBoundsSecond});

  final Offset? multiSelectBoundsFirst;
  final Offset? multiSelectBoundsSecond;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: CustomPaint(
        painter: _MyPainter(
          multiSelectBoundsFirst: multiSelectBoundsFirst,
          multiSelectBoundsSecond: multiSelectBoundsSecond,
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {

  const _MyPainter({this.multiSelectBoundsFirst, this.multiSelectBoundsSecond});

  final Offset? multiSelectBoundsFirst;
  final Offset? multiSelectBoundsSecond;

  @override
  void paint(Canvas canvas, Size size) {
    final multiSelectBoundsFirst = this.multiSelectBoundsFirst;
    if (multiSelectBoundsFirst == null) {
      return;
    }
    final multiSelectBoundsSecond = this.multiSelectBoundsSecond;
    if (multiSelectBoundsSecond == null) return;
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    final rect = Rect.fromLTRB(
      min(multiSelectBoundsFirst.dx, multiSelectBoundsSecond.dx),
      min(multiSelectBoundsFirst.dy, multiSelectBoundsSecond.dy),
      max(multiSelectBoundsFirst.dx, multiSelectBoundsSecond.dx),
      max(multiSelectBoundsFirst.dy, multiSelectBoundsSecond.dy),
    );
    final paint = Paint();
    paint.color = const Color(0x303232ff);
    paint.style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);
    paint.color = const Color(0x663232ff);
    paint.style = PaintingStyle.stroke;
    canvas.drawRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _MyPainter oldDelegate) {
    return oldDelegate.multiSelectBoundsFirst != multiSelectBoundsFirst
        || oldDelegate.multiSelectBoundsSecond != multiSelectBoundsSecond;
  }

}