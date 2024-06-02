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

  final FocusNode focusNode=FocusNode();
  final TextEditingController controller=TextEditingController();
  bool enable=true;

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
          enable=false;
          setState(() {});
        },
      ),
      body: SizedBox.expand(
        child: Container(
          color: Colors.blue.withAlpha(80),
          child: CustomPaint(
            painter: MyPainter(),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {

  Paint paint1=Paint()..color=Colors.red;
  Paint paint2=Paint()..color=Colors.green;
  Paint paint3=Paint()..color=Colors.white.withAlpha(80);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    Rect rect1 = const Rect.fromLTWH(100, 100, 500, 500);
    Rect rect2 = const Rect.fromLTWH(300, 300, 500, 500);
    canvas.drawRect(rect1, paint1);
    canvas.clipRect(rect1);
    canvas.drawRect(rect2, paint2);
    canvas.restore();
    canvas.drawRect(rect2, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

