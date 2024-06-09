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

  FocusNode f1=FocusNode();
  FocusNode f2=FocusNode();
  FocusNode f3=FocusNode();

  TextEditingController controller1=TextEditingController()..text="1234567890";
  TextEditingController controller2=TextEditingController()..text="1234567890";
  TextEditingController controller3=TextEditingController()..text="1234567890";

  ScrollController scrollController=ScrollController();

  listenerScroll(){
    print("${scrollController.hashCode} 滚动！");
    // debugPrintStack();
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(listenerScroll);
  }


  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(listenerScroll);
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: Center(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              TextField(
                focusNode: f1,
                controller: controller1,
              ),
              TextField(
                focusNode: f2,
                controller: controller2,
              ),
              TextField(
                focusNode: f3,
                controller: controller3,
              ),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
            ],
          ),
        ),
      ),
    );
  }
}

