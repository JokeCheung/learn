import 'dart:math';

import 'package:flutter/material.dart';
//demo: InheritedWidget用法
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Color? color;

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              Random random=Random();
              int r=random.nextInt(255);
              int g=random.nextInt(255);
              int b=random.nextInt(255);
              color=Color.fromARGB(255, r, g, b);
            });
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        body: ColorChange(
          color: color,
          child:  SizedBox(
            width: 500,
            height: 500,
            child: Container(
              color: Colors.red,
              child: const Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Foo(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Foo extends StatelessWidget {
  const Foo({super.key});

  @override
  Widget build(BuildContext context) {
    ColorChange? colorChange=context.dependOnInheritedWidgetOfExactType<ColorChange>();
    return Container(color: colorChange?.color);
  }
}

class ColorChange extends InheritedWidget{

  final Color? color;

  const ColorChange({super.key, required this.color, required super.child});

  @override
  bool updateShouldNotify(covariant ColorChange oldWidget) {
    return oldWidget.color!=color;
  }

}


