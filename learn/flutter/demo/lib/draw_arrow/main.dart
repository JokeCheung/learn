import 'package:demo/draw_arrow/arrow_painter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset? startOffset = Offset.zero;
  Offset? endOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: SizedBox.expand(
        child: GestureDetector(
          onScaleStart: (details) {
            startOffset=details.localFocalPoint;

          },
          onScaleUpdate: (details) {
            endOffset=details.localFocalPoint;
            // print("end=$endOffset");
            setState(() {});
          },
          onScaleEnd: (details) {
            setState(() {});
          },
          child: CustomPaint(
            painter: ArrowPainter(
              start: startOffset,
              end: endOffset,
            ),
          ),
        ),
      ),
    );
  }
}
