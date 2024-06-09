import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  State<MyHomePage> createState() => MyHomePageState();

  static MyHomePageState of(BuildContext context) {
    return context.findRootAncestorStateOfType<MyHomePageState>()!;
  }
}

class MyHomePageState extends State<MyHomePage> {
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();

  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    f1.addListener(() {
      if (f1.hasFocus) {
        print("f1 hasFocus");
      }
    });
    f2.addListener(() {
      if (f2.hasFocus) {
        print("f2 hasFocus");
      }
    });
    f3.addListener(() {
      if (f3.hasFocus) {
        print("f3 hasFocus");
      }
    });
    f4.addListener(() {
      if (f4.hasFocus) {
        print("f4 hasFocus");
      }
    });
    f5.addListener(() {
      if (f5.hasFocus) {
        print("f5 hasFocus");
      }
    });
    f6.addListener(() {
      if (f6.hasFocus) {
        print("f6 hasFocus");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var focusNode = FocusManager.instance.primaryFocus;
          BoxState? state = focusNode?.context?.findAncestorStateOfType<BoxState>();
          if (state != null) {
            setState(() {
              // state.num++;
            });
          } else {
            print("state==null");
          }
        },
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            Box(
              focusNode: f1,
              color: Colors.red,
            ),
            Box(focusNode: f2, color: Colors.yellow),
            Box(focusNode: f3, color: Colors.green),
            Box(
              focusNode: f4,
              color: Colors.orange,
            ),
            Box(focusNode: f5, color: Colors.blue),
            Box(focusNode: f6, color: Colors.purple),
          ],
        ),
      ),
    );
  }
}

class Box extends StatefulWidget {
  final FocusNode focusNode;
  final Color color;

  const Box({
    super.key,
    required this.focusNode,
    required this.color,
  });

  @override
  State<Box> createState() => BoxState();
}

class BoxState extends State<Box> {
  ScrollController controller = ScrollController();

  ScrollController get parentController {
    MyHomePageState state = MyHomePage.of(context);
    return state.controller;
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      print("内部controller响应");
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      child: GestureDetector(
        onTap: () {
          widget.focusNode.requestFocus();
        },
        child: Scrollable(
          controller: controller,
          viewportBuilder: (BuildContext context, ViewportOffset position) {
            return Container(
              width: 200,
              height: 200,
              color: widget.color,
              child: Center(
                child: Text(
                  "${position.pixels}",
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
