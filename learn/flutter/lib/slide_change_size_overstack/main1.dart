import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_flutter/slide_change_size/divider_resize_line.dart';

import 'resize_line_stackover.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final detailWidthNotifier = ValueNotifier<ControllerModel>(ControllerModel(0,false));

  // final ValueNotifier<double> controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResizeLine(
        overPos: OverPosType.left,
        controller: detailWidthNotifier,
        minWidth: 1,
        maxWidth: 1000,
        onDragEnd: (width) async {
          // _detailExpandedWidth = width;
          // await MinderEditorSpec.pref
          //     .setDouble(_prefKey, width);
        },
        bottomChild: Container(
            color: Colors.yellow, child: const Center(child: SizedBox(
            width:1,child: Text("bottom")))),
        overChild: Container(
            color: Colors.blue, child: const Center(child: Text("over"))),
      ),
    );
  }
}

class ColorBlock extends StatefulWidget {
  final Color color;

  const ColorBlock({super.key, required this.color});

  @override
  State<ColorBlock> createState() => _ColorBlockState();
}

class _ColorBlockState extends State<ColorBlock> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: MouseRegion(
        onEnter: (PointerEnterEvent event) {
          print("onEnter");
          setState(() {
            hover = true;
          });
        },
        onExit: (PointerExitEvent event) {
          print("onExit");
          setState(() {
            hover = false;
          });
        },
        child: Container(
          color: hover ? Colors.green : widget.color,
        ),
      ),
    );
  }
}
