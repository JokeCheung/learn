import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArrowPainter extends CustomPainter {
  Offset? start;
  Offset? end;

  final Paint _paint = Paint()
    ..isAntiAlias = true
    ..strokeWidth = 2.0
    ..style = PaintingStyle.fill
    ..color = Colors.red;

  ArrowPainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
    if (start == null || end == null) return;
    final beforeTime = DateTime.now().millisecondsSinceEpoch;
    double maxL = 20; //箭头三角形最大高度
    double minL = 5; //箭头三角形最小高度
    double switchMaxLength = 100; //大于100像素箭头变最大
    double distanceES = (end! - start!).distance;
    double kSE = (end!.dy - start!.dy).abs() / (end!.dx - start!.dx).abs();
    double k = 1 / kSE; //SE垂直于SP
    double l = maxL;
    if (distanceES < switchMaxLength) {
      double scaleSize=distanceES / switchMaxLength * maxL;
      l =max(scaleSize,minL);
    }

    double x1;
    double x2;
    double y1;
    double y2;
    Offset p1;
    Offset p2;
    Path path = Path();

    Offset? startTarget;

    Offset o = end! - start!;
    if (kSE.isInfinite) {
      print("kSE=$kSE");
      if (o.dy < 0) {
        startTarget = Offset(end!.dx, end!.dy + l);
      } else {
        startTarget = Offset(end!.dx, end!.dy - l);
      }
    } else {
      x1 = sqrt(pow(l, 2) / (pow(kSE, 2) + 1)) + end!.dx;
      y1 = kSE * sqrt(pow(l, 2) / (pow(kSE, 2) + 1)) + end!.dy;
      x2 = -sqrt(pow(l, 2) / (pow(kSE, 2) + 1)) + end!.dx;
      y2 = -kSE * sqrt(pow(l, 2) / (pow(kSE, 2) + 1)) + end!.dy;

      //1象限
      if (o.dx > 0 && o.dy <= 0) {
        double x = min(x1, x2);
        double y = max(y1, y2);
        startTarget = Offset(x, y);
      }

      //2象限
      if (o.dx < 0 && o.dy < 0) {
        double x = max(x1, x2);
        double y = max(y1, y2);
        startTarget = Offset(x, y);
      }

      //3象限
      if (o.dx < 0 && o.dy >= 0) {
        double x = max(x1, x2);
        double y = min(y1, y2);
        startTarget = Offset(x, y);
      }

      //4象限
      if (o.dx > 0 && o.dy > 0) {
        double x = min(x1, x2);
        double y = min(y1, y2);
        startTarget = Offset(x, y);
      }
    }

    _paint.style = PaintingStyle.fill;
    _paint.color = Colors.red;
    // canvas.drawCircle(startTarget!, 4, _paint);

    ////////////////////////////////绘制P1 P2/////////////////////////////////////////
    if (startTarget == null) return;
    canvas.drawLine(start!, startTarget, _paint);
    if (k.isInfinite) {
      x1 = startTarget.dx;
      x2 = startTarget.dx;
      y1 = startTarget.dy + l;
      y2 = startTarget.dy - l;
      p1 = Offset(x1, y1);
      p2 = Offset(x2, y2);
    } else {
      x1 = sqrt(pow(l, 2) / (pow(k, 2) + 1)) + startTarget.dx;
      y1 = k * sqrt(pow(l, 2) / (pow(k, 2) + 1)) + startTarget.dy;
      x2 = -sqrt(pow(l, 2) / (pow(k, 2) + 1)) + startTarget.dx;
      y2 = -k * sqrt(pow(l, 2) / (pow(k, 2) + 1)) + startTarget.dy;

      Offset o = end! - start!;
      if (o.dx > 0 && o.dy > 0 || o.dx < 0 && o.dy < 0) {
        p1 = Offset(x1, y2);
        p2 = Offset(x2, y1);
      } else {
        p1 = Offset(x1, y1);
        p2 = Offset(x2, y2);
      }
    }
    path.moveTo(p1.dx, p1.dy);
    path.lineTo(end!.dx, end!.dy);
    path.lineTo(p2.dx, p2.dy);
    path.close();
    canvas.drawPath(path, _paint);

    final endTime = DateTime.now().millisecondsSinceEpoch;
    int dealTime=endTime - beforeTime;
    print("beforeTime=$beforeTime");
    print("endTime=$endTime");
    print("绘制一次耗时：$dealTime");
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
