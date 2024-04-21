import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
  Offset offset = Offset.zero;

  FocusNode focusNode = FocusNode();
  FocusNode focusNodeText1 = FocusNode();
  FocusNode focusNodeText2 = FocusNode();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      print("焦点改变");
      print("$focusNode");
      print("primaryFocus==${FocusManager.instance.primaryFocus}");
    });
    // focusNode.addListener(() {
    //   if(focusNode.hasFocus){
    //     print("image focusNode hasFocus");
    //   }else{
    //     print("image focusNode loseFocus");
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print("object");
          focusNodeText2.requestFocus();
        },
      ),
      body: Container(
        color: Colors.grey,
        child: AnimatedSlide(
          offset: offset,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 500),
          child: Focus(
            onKeyEvent: (node, event) {
              if (event.physicalKey == PhysicalKeyboardKey.backspace) {
                if(event is KeyDownEvent){
                  print("退格键按下");
                }

                if(event is KeyUpEvent){
                  print("退格键松手");
                }

              }
              return KeyEventResult.handled;
            },
            child: Column(
              children: [
                 TextField(
                  focusNode: focusNodeText1,
                ),
                 TextField(
                   focusNode: focusNodeText2,
                ),
                 ColorBlock(
                    color: Colors.white,
                    focusNode: focusNode,
                  ),
              ],
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
  final FocusNode focusNode;

  const ColorBlock({super.key, required this.color, required this.focusNode});

  @override
  State<ColorBlock> createState() => ColorBlockState();
}

class ColorBlockState extends State<ColorBlock> {
  bool hover = false;

  FocusNode get focusNode => widget.focusNode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      child: GestureDetector(
        onTap: () {
          // print("primaryFocus==${FocusManager.instance.primaryFocus}");
          // print("focusNode==$focusNode");
          // debugDumpFocusTree();
          focusNode.requestFocus();
          // print("primaryFocus==${FocusManager.instance.primaryFocus}");
          // print("focusNode==$focusNode");
          // debugDumpFocusTree();
        },
        child: SizedBox(
          width: 100,
          height: 100,
          child: Container(
            color: Colors.cyan,
          ),
        ),
      ),
    );
  }
}
