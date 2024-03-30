import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_flutter/slide_change_size/divider_resize_line.dart';

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
  Offset offset= Offset.zero;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("object");
          setState(() {
            offset=Offset(offset.dx+0.5, offset.dy);
          });
        },
      ),
      body: Container(
        color: Colors.grey,
        child: AnimatedSlide(
          offset:offset,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 500),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Container(
              color: Colors.cyan,
            ),
          ),
        ),
      ),
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


