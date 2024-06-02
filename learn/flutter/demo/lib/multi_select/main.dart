import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'multi_select_bounds_view.dart';

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

  Offset? multiSelectBoundsFirst;
  Offset? multiSelectBoundsSecond;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("object");
        },
      ),
      body:GestureDetector(
          onScaleStart: (ScaleStartDetails details){
            print("onScaleStart ");
            multiSelectBoundsFirst = details.localFocalPoint;
          },
          onScaleUpdate:(ScaleUpdateDetails details){
            print("onScaleUpdate ");
            if (multiSelectBoundsFirst != null) {
              multiSelectBoundsSecond =
                  details.localFocalPoint;
              setState(() {});
              return;
            }
          } ,
          onScaleEnd: (ScaleEndDetails details){
            print("ScaleEndDetails ");
            if (multiSelectBoundsFirst != null ||
                multiSelectBoundsSecond != null) {
              multiSelectBoundsFirst = null;
              multiSelectBoundsSecond = null;
              setState(() {});
              return;
            }
          },
          child: Container(
            color: Colors.red.withAlpha(150),
            width: 300,
            height: 300,
            child: MultiSelectBoundsView(
              multiSelectBoundsFirst: multiSelectBoundsFirst,
              multiSelectBoundsSecond: multiSelectBoundsSecond,
            ),
          ),
        ),
    );
  }
}
