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
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      //   useMaterial3: true,
      // ),
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
        maxWidth: 800,
        onDragEnd: (width) async {
          // _detailExpandedWidth = width;
          // await MinderEditorSpec.pref
          //     .setDouble(_prefKey, width);
        },
        leftChild: Container(
          color: Colors.yellow,
          child: const Center(child: Text("Left")),
        ),
        rightChild:  Container(
            color: Colors.blue,
          child: const Center(child: Text("Right")),
        ),
      ),

      // body: Row(
      //   children: [
      //     ColorBlock(color: Colors.red),
      //     DividerResizeLineHorizontal(),
      //     ColorBlock(color: Colors.blue),
      //   ],
      // ),
    );
  }
}

// class DividerResizeLineHorizontal extends StatefulWidget {
//   const DividerResizeLineHorizontal({super.key});
//
//   @override
//   State<DividerResizeLineHorizontal> createState() => _DividerResizeLineHorizontalState();
// }
//
// class _DividerResizeLineHorizontalState extends State<DividerResizeLineHorizontal> {
//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       width: 6,
//       child: ColorBlock(
//         color: Colors.black,
//       ),
//     );
//   }
// }


class ColorBlock extends StatefulWidget {
  final Color color;
  const ColorBlock({super.key, required this.color});

  @override
  State<ColorBlock> createState() => _ColorBlockState();
}

class _ColorBlockState extends State<ColorBlock> {
  bool hover=false;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: MouseRegion(
        onEnter: (PointerEnterEvent event){
          print("onEnter");
          setState(() {
            hover=true;
          });
        },
        onExit: (PointerExitEvent event){
          print("onExit");
          setState(() {
            hover=false;
          });
        },
        child: Container(
          color: hover?Colors.green:widget.color,
        ),
      ),
    );
  }
}

