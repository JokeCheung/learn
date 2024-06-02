import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class SelectButton extends StatefulWidget {
  final String text;
  final bool enable;
  final Function() callbackClear;
  final Function() onTap;
  final void Function(BuildContext context,Rect rect)? onMouseEnterOrTap;
  final void Function(BuildContext context,PointerExitEvent event)? onMouseExit;

  const SelectButton({
    super.key,
    required this.text,
    required this.enable,
    required this.callbackClear,
    required this.onTap,
    this.onMouseEnterOrTap,
    this.onMouseExit,
  });

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: MouseRegion(
        onEnter: (e) {
          final renderObject = context.findRenderObject();
          if (renderObject is RenderBox) {
            final size = renderObject.size;
            final leftTop = renderObject.localToGlobal(Offset.zero);
            widget.onMouseEnterOrTap?.call(context,leftTop & size);
          }
        },
        onExit: (e){
          widget.onMouseExit?.call(context,e);
        },
        child: Material(
          color: widget.enable ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(5.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(5.0),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(widget.text),
            ),
            onTap: () {
              widget.callbackClear.call();
              widget.onTap.call();
            },
          ),
        ),
      ),
    );
  }
}