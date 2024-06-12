import 'package:flutter/material.dart' hide TextEditingController;
import 'editable_text.dart';
import 'text_field.dart';
import 'view/my_text_field.dart';


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

  TextEditingController controller1=TextEditingController()..text="123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890";
  TextEditingController controller2=TextEditingController()..text="123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890";
  TextEditingController controller3=TextEditingController()..text="123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890";

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
              MyTextField(
                focusNode: f1,
                controller: controller1,
                maxLines: null,
              ),
              MyTextField(
                focusNode: f2,
                controller: controller2,
                maxLines: null,
              ),
              MyTextField(
                focusNode: f3,
                controller: controller3,
                maxLines: null,
              ),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
              MyTextField(),
            ],
          ),
        ),
      ),
    );
  }
}

