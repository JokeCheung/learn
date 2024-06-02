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
    controller.addListener(() {
      print("addListener");
      // focusNode.unfocus();
      //  if(controller.text.isNotEmpty){
      //    enable=false;
      //    setState(() {});
      //  }
    });
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
          height: 500,
          color: Colors.lightGreenAccent,
          child: Center(
            child: Container(
              width: 200,
              height: 200,
              color: Colors.pink,
              child: const MyStack(),
            ),
          ),
        ),
      ),
    );
  }
}

class MyStack extends StatefulWidget {
  const MyStack({super.key});

  @override
  State<MyStack> createState() => _MyStackState();
}

class _MyStackState extends State<MyStack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: MyPainter(),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print("size=$size");
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 10;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
