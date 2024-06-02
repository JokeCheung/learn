import 'package:demo/pop_menu_button/editor_mouse_popup_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final layoutKey = GlobalKey();

  // final ValueNotifier<double> controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DividerResizeLineHorizontal(
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
        // rightChild: LayoutBuilder(
        //   key: layoutKey,
        //     builder: (context,c){
        //       return RightChild(layoutKey: layoutKey,);
        //     },
        //    ),
        rightChild: NotificationListener(
          onNotification: (n){
            print("n is ${n.runtimeType}");
            return false;
          },
          child: RightChild(
            layoutKey: layoutKey,
          ),
        ),
      ),
    );
  }
}

class RightChild extends StatefulWidget {
  final GlobalKey layoutKey;

  const RightChild({super.key, required this.layoutKey});

  @override
  State<RightChild> createState() => _RightChildState();
}

class _RightChildState extends State<RightChild> {
  static const String imgPath = 'lib/slide_change_size/assets/image_scale.png';
  double width = 0;

  @override
  Widget build(BuildContext context) {
    print("RightChild build");

    return /* SizeChangedLayoutNotifier(*/
        // child: LayoutBuilder(
        //   builder: (context,constraints){
        //     print("Size change maxWidth=${constraints.maxWidth}");
        //     return  Container(
        //       color: Colors.pink,
        //       child: Center(
        //         child: Image.asset(
        //           imgPath,
        //           width: constraints.maxWidth/2,
        //           height: constraints.maxWidth/2,
        //         ),
        //       ),
        //     );
        //   },
        // ),
        //  MeasuredSizeWidget(
        //  onChange: (size){
        //   print("onChange $size");
        //   width=size.width/2;
        //   setState(() {});
        // },
        //   child: Container(
        //     color: Colors.pink,
        //     child: Center(
        //       child: Image.asset(
        //         imgPath,
        //         width: width,
        //         height: width,
        //       ),
        //     ),
        //   ),
        // );
        SizeChangedLayoutNotifier(
      child: Container(
        color: Colors.pink,
        child: Center(
          child: Image.asset(
            imgPath,
            width: width,
            height: width,
          ),
        ),
      ),
    );
  }

  double getWidth() {
    // RenderBox? box=widget.layoutKey.currentContext?.findRenderObject() as RenderBox?;
    // if(box!=null && box.hasSize){
    //   return box.size.width/2;
    // }
    return 0;
  }
}
