import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'resize_cover.dart';

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
  final detailWidthNotifier =
      ValueNotifier<ControllerModel>(ControllerModel(0, false));

  // final ValueNotifier<double> controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResizeCover(
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
          color: Colors.yellow,
          child: const Center(
            child: SizedBox(
              width: 1,
              child: Text("bottom"),
            ),
          ),
        ),
        overChild: Container(
          color: Colors.pink,
          child: const Center(
            child: Text("over"),
          ),
        ),
      ),
    );
  }
}


