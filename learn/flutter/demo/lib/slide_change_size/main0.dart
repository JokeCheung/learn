import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'divider_resize_line.dart';


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

  final detailWidthNotifier = ValueNotifier<double>(0);
  // final ValueNotifier<double> controller;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:DividerResizeLineHorizontal(
        mainChild: DividerMainChild.right,
        controller: detailWidthNotifier,
        minWidth: 200,
        maxWidth: 1000,
        onDragEnd: (width) async {
          print("结束拖拽!");
        },
        leftChild: Container(
          color: Colors.yellow,
          child: const Center(child: Text("left")),
        ),
        rightChild:  Container(
            color: Colors.pink,
          child: const Center(child: Text("right")),
        ),
      ),

    );
  }
}


