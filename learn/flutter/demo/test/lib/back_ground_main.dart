import 'package:flutter/material.dart';

import 'canvas_main.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            children: [
              Container(
                color: Colors.red,
                width: 200,
                height: 200,
                child: CustomPaint(
                  painter: MyCustomPainter(),
                ),
              ),
              Container(
                color: Colors.blue,
                width: 200,
                height: 200,
                // child: CustomPaint(
                //   painter: MyCustomPainter(),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint=Paint()..color=Colors.black;
    Rect rect=Rect.fromLTWH(0, size.height/2, 2*size.width, size.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

