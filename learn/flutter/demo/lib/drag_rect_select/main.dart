import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'drag_rect_bounds_view.dart';

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
  bool isSelect = false;
  GlobalKey blockKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: ColoredBox(
              color: Colors.limeAccent.shade400.withAlpha(100),
              child: Center(
                child: Container(
                  key: blockKey,
                  width: 50,
                  height: 50,
                  color: isSelect ? Colors.red : Colors.blue,
                ),
              ),
            ),
            // child: const SizedBox(),
          ),
          GestureDetector(
            onScaleStart: (ScaleStartDetails details) {
              multiSelectBoundsFirst = details.localFocalPoint;
            },
            onScaleUpdate: (ScaleUpdateDetails details) {
              if (multiSelectBoundsFirst != null) {
                multiSelectBoundsSecond = details.localFocalPoint;
                RenderBox? childBox =
                    blockKey.currentContext?.findRenderObject() as RenderBox?;
                RenderBox? parentBox = context.findRenderObject() as RenderBox?;
                if (childBox == null) {
                  print("childBox == null");
                  return;
                }

                Offset o =
                    childBox.localToGlobal(Offset.zero, ancestor: parentBox);
                Rect boxRect = Rect.fromLTWH(
                    o.dx, o.dy, childBox.size.width, childBox.size.height);

                double left = min(
                    multiSelectBoundsFirst!.dx, multiSelectBoundsSecond!.dx);
                double top = min(
                    multiSelectBoundsFirst!.dy, multiSelectBoundsSecond!.dy);
                double right = max(
                    multiSelectBoundsFirst!.dx, multiSelectBoundsSecond!.dx);
                double bottom = max(
                    multiSelectBoundsFirst!.dx, multiSelectBoundsSecond!.dx);
                Rect selectRect = Rect.fromLTRB(left, top, right, bottom);

                print("selectRect == $selectRect");

                isSelect = selectRect.overlaps(boxRect);
                print("isSelect=$isSelect");
                setState(() {});
                return;
              }
            },
            onScaleEnd: (ScaleEndDetails details) {
              if (multiSelectBoundsFirst != null ||
                  multiSelectBoundsSecond != null) {
                multiSelectBoundsFirst = null;
                multiSelectBoundsSecond = null;
                isSelect = false;
                setState(() {});
              }
            },
            child: Container(
              color: Colors.grey.withAlpha(100),
              child: SizedBox.expand(
                child: DragRectBoundsView(
                  multiSelectBoundsFirst: multiSelectBoundsFirst,
                  multiSelectBoundsSecond: multiSelectBoundsSecond,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
