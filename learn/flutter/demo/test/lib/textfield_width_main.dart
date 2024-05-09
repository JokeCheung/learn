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
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  bool enable = true;

  @override
  void initState() {
    super.initState();
    controller.text = "Hello World";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          enable = false;
          setState(() {});
        },
      ),
      body: Center(
        child: Container(
          width: 500,

          color: Colors.lightGreenAccent.withAlpha(100),
          child: Stack(
            children: [
              TextField(
                focusNode: focusNode,
                controller: controller,
                enabled: enable,
                cursorWidth: 1,
                // strutStyle: const StrutStyle(
                //   fontSize: 28,
                //   forceStrutHeight: false,
                // ),
                decoration: null,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
                  scrollPadding:EdgeInsets.zero,
              ),
              CustomPaint(
                painter: MyPainter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    TextPainter textPainterSize = TextPainter(
      textWidthBasis: TextWidthBasis.parent,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
    );

    textPainterSize.text = const TextSpan(children: [
      TextSpan(
        text: "Hello World",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 18,
        ),
      ),
    ]);

    textPainterSize.layout();
    textPainterSize.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
