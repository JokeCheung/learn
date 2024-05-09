import 'package:flutter/material.dart';


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

/////////////////////////////////////////////////////////////////////////////////
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final FocusNode focusNode=FocusNode();
  final TextEditingController controller=TextEditingController();
 bool enable=true;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      print("addListener");
     // focusNode.unfocus();
     //  if(controller.text.isNotEmpty){
     //    enable=false;
     //    setState(() {});
     //  }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          enable=false;
          setState(() {});
        },
      ),
      body: Center(
        child: Container(
          width: 500,
          color: Colors.lightGreenAccent,
          child: TextField(
            focusNode: focusNode,
            controller: controller,
            enabled: enable,
          ),
        ),
      ),
    );
  }
}

