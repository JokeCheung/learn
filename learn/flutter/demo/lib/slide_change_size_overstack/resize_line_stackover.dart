import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum OverPosType {
  left,
  right,
}

class ResizeLine extends StatefulWidget {
  const ResizeLine({
    super.key,
    required this.controller,
    required this.maxWidth,
    required this.minWidth,
    required this.bottomChild,
    required this.overChild,
    this.onDragEnd,
    this.overPos = OverPosType.left,
  });

  final OverPosType overPos;
  final ValueNotifier<ControllerModel> controller;
  final double maxWidth;
  final double minWidth;
  final Widget bottomChild;
  final Widget overChild;
  final void Function(double width)? onDragEnd;
  static const dragLineHitWidth = 3.0;

  @override
  State<ResizeLine> createState() => _ResizeLineState();
}

class _ResizeLineState extends State<ResizeLine> {

  // Offset offset= Offset.zero;
  double width=0;

  Widget _buildHitLine() {
    return SizedBox(
      width: ResizeLine.dragLineHitWidth,
      height: double.infinity,
      child: _HitLine(
        mainChild:widget.overPos,
        controller: widget.controller,
        maxWidth: widget.maxWidth,
        minWidth: widget.minWidth,
        onDragEnd: widget.onDragEnd,
      ),
    );
  }

  Widget _buildMainChildHolder() {
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (context, value, child) {
        return SizedBox(
          width: max(0.0, value.width - ResizeLine.dragLineHitWidth / 2.0),
          height: double.infinity,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget over = _OverChild(controller: widget.controller, child: widget.overChild);
    Widget bottom  = _BottomChild(child:  widget.bottomChild);
    // Widget bottom  = Container();
    MainAxisAlignment holderAlignment;
    List<Widget> holderChildren;
    //可调节面板放在左侧
    if (widget.overPos == OverPosType.left) {
      holderAlignment = MainAxisAlignment.start;
      holderChildren = [
        over,
        _buildHitLine(),
      ];
    //可调节面板放在右侧
    } else {
      holderAlignment = MainAxisAlignment.end;
      holderChildren = [
        _buildHitLine(),
        over,
      ];
    }

    return Stack(
      children: [
        bottom,

        Row(
          mainAxisAlignment: holderAlignment,
          children:holderChildren,
        ),

        Align(
          alignment: Alignment.bottomRight,
          child: MaterialButton(
          onPressed: (){
            print("MaterialButton onPressed");
            if(widget.controller.value.width==0){
              widget.controller.value=ControllerModel(500, false);
            }else{
              widget.controller.value=ControllerModel(0,false);
            }
          },
          child: const Text(
            "点击按钮",
          )
          ),
        ),
      ],
    );
  }
}

class _OverChild extends StatelessWidget {
  const _OverChild({
    super.key,
    required this.controller,
    required this.child,
  });

  final ValueNotifier<ControllerModel> controller;
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    // return child;
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (BuildContext context, ControllerModel value, Widget? child) {
        print("_OverChild value=${value.drag}");
        //拖拽不执行动画
        if(value.drag){
          return Container(
            width: value.width,
            height: double.infinity,
            child: child,
          );
        }else{
          return AnimatedContainer(
            width: value.width,
            height: double.infinity,
            duration: const Duration(milliseconds: 250),
            child: child,
          );
        }

        //手动展开执行动画

      },
      child: ClipRect(child: child),
    );
    // return SizedBox(
    //   width: 500,
    //   child: child,
    // );
  }
}


class _BottomChild extends StatelessWidget {

  final Widget child;
  const _BottomChild({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
class ControllerModel{
  double width;
  bool drag;

  ControllerModel(this.width,this.drag);

  static copy(ControllerModel model){
    return ControllerModel(model.width,model.drag);
  }
}


class _HitLine extends StatefulWidget {
  const _HitLine({
    super.key,
    required this.controller,
    required this.maxWidth,
    required this.minWidth,
    this.mainChild = OverPosType.left,
    this.onDragEnd,
  });

  final OverPosType mainChild;
  final ValueNotifier<ControllerModel> controller;
  final double maxWidth;
  final double minWidth;
  final void Function(double width)? onDragEnd;

  @override
  State<_HitLine> createState() => _HitLineState();
}

class _HitLineState extends State<_HitLine> with SingleTickerProviderStateMixin  {

  bool _isMouseEnter = false;
  bool _isDragging = false;

  double _width = 0;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    reverseDuration: const Duration(milliseconds: 100),
  );

  void _setMouseEnter(bool isEnter) {
    print("_setMouseEnter isEnter=$isEnter");
    if (_isMouseEnter != isEnter) {
      _isMouseEnter = isEnter;
      _runAnim();
    }
  }

  void _setDragging(bool isDragging) {

    if (_isDragging != isDragging) {
      _isDragging = isDragging;
      _runAnim();
    }
  }

  void _runAnim() {
    print("_runAnim");
    if (_isMouseEnter || _isDragging) {
      print("_runAnim _controller.forward()");
      _controller.forward();
    } else {
      print("_runAnim _controller.reverse()");
      _controller.reverse();
    }
  }

  void _onDragStart(DragStartDetails details) {
    _setDragging(true);
    _width = widget.controller.value.width;
  }

  void _onDragUpdate(DragUpdateDetails details) {

    final d = widget.mainChild == OverPosType.left ? 1 : -1;
    _width += (d * details.delta.dx);
    final double result;
    if (_width < widget.minWidth) {
      result = widget.minWidth;
    } else if (_width > widget.maxWidth) {
      result = widget.maxWidth;
    } else {
      result = _width;
    }

    widget.controller.value=ControllerModel(result,_isDragging);
  }

  void _onDragCancel() {
    _setDragging(false);
  }

  void _onDragEnd(_) {
    widget.onDragEnd?.call(widget.controller.value.width);
    _setDragging(false);
  }

  void _onMouseEnter(_) {
    _setMouseEnter(true);
  }

  void _onMouseExit(_) {
    _setMouseEnter(false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeRight,
      onEnter: _onMouseEnter,
      onExit: _onMouseExit,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragCancel: _onDragCancel,
        onHorizontalDragEnd: _onDragEnd,
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // final uiColor = UiColor.of(context);
              // final compositeColor = ColorUtils.compositeColors(
              //   uiColor.colorAccent.withOpacity(_controller.value).value,
              //   uiColor.divider.value,
              // );
              return Container(
                width: ResizeLine.dragLineHitWidth,
                color: Colors.grey,
              );
            },
          ),
        ),
      ),
    );
  }
}

