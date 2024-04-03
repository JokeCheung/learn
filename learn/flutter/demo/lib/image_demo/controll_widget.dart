import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ControllerWidget extends StatefulWidget {
  final Size size;
  const ControllerWidget({super.key,required this.size});

  @override
  State<ControllerWidget> createState() => _ControllerWidgetState();
}

class _ControllerWidgetState extends State<ControllerWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //左边控制条
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 10,
            height: widget.size.height,
            color: Colors.red,
          ),
        ),
        //上边控制条
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: widget.size.width-10,
            height:10,
            color: Colors.yellow,
          ),
        ),
        //右边控制条
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 10,
            height: widget.size.height,
            color: Colors.blue,
          ),
        ),
        //底边控制条
        Align(
          alignment:Alignment.topLeft,
          child: Container(
            width: widget.size.width-10,
            height:10,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }
}
