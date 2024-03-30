import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learn_flutter/provider/provider/ui/control_panel.dart';
import 'package:learn_flutter/provider/provider/ui/logo.dart';
import 'logo_model.dart';
import 'package:provider/provider.dart';
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

    print("_MyAppState build");

    return ChangeNotifierProvider(
      create: (BuildContext context)=>LogoModel(),
      child: MaterialApp(
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
            child: const Column(
              children: [
                Logo(),
                ControllerPanel(),
              ],
            ),
          ),
        ),
      ),
    );
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


