import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DividerMainChild {
  left,
  right,
}

class DividerResizeLineHorizontal extends StatefulWidget {
  const DividerResizeLineHorizontal({
    super.key,
    required this.controller,
    required this.maxWidth,
    required this.minWidth,
    required this.leftChild,
    required this.rightChild,
    this.onDragEnd,
    this.mainChild = DividerMainChild.left,
  });

  final DividerMainChild mainChild;
  final ValueNotifier<double> controller;
  final double maxWidth;
  final double minWidth;
  final Widget leftChild;
  final Widget rightChild;
  final void Function(double width)? onDragEnd;
  static const dragLineHitWidth = 6.0;

  @override
  State<DividerResizeLineHorizontal> createState() => _DividerResizeLineHorizontalState();
}

class _DividerResizeLineHorizontalState extends State<DividerResizeLineHorizontal> {

  Widget _buildHitLine() {
    return SizedBox(
      width: DividerResizeLineHorizontal.dragLineHitWidth,
      height: double.infinity,
      child: _HitLine(
        mainChild:widget.mainChild,
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
          width: max(0.0, value - DividerResizeLineHorizontal.dragLineHitWidth / 2.0),
          height: double.infinity,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget left = widget.leftChild;
    Widget right = widget.rightChild;
    MainAxisAlignment holderAlignment;
    List<Widget> holderChildren;
    if (widget.mainChild == DividerMainChild.left) {
      left = _MainChild(controller: widget.controller, child: left);
      right = _SecondaryChild(child: right);
      holderAlignment = MainAxisAlignment.start;
      holderChildren = [
        _buildMainChildHolder(),
        _buildHitLine(),
      ];
    } else {
      left = _SecondaryChild(child: left);
      right = _MainChild(controller: widget.controller, child: right);
      holderAlignment = MainAxisAlignment.end;
      holderChildren = [
        _buildHitLine(),
        _buildMainChildHolder(),
      ];
    }


    return Stack(
      children: [
        Row(
          children: [
            left,
            const SizedBox(width: 2), // 空出Divider的位置
            right,
          ],
        ),
        Row(
          mainAxisAlignment: holderAlignment,
          children: holderChildren,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: MaterialButton(
          onPressed: (){
            print("MaterialButton onPressed");
            if(widget.controller.value==0){
              widget.controller.value=500;
            }else{
              widget.controller.value=0;
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

class _MainChild extends StatelessWidget {
  const _MainChild({
    super.key,
    required this.controller,
    required this.child,
  });

  final ValueNotifier<double> controller;
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        return SizedBox(
          width: value,
          height: double.infinity,
          child: child!,
        );
      },
      child: child,
    );
  }
}

class _SecondaryChild extends Expanded {
  const _SecondaryChild({super.key, required super.child});
}

class _HitLine extends StatefulWidget {
  const _HitLine({
    super.key,
    required this.controller,
    required this.maxWidth,
    required this.minWidth,
    this.mainChild = DividerMainChild.left,
    this.onDragEnd,
  });

  final DividerMainChild mainChild;
  final ValueNotifier<double> controller;
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
    _width = widget.controller.value;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final d = widget.mainChild == DividerMainChild.left ? 1 : -1;
    _width += (d * details.delta.dx);
    final double result;
    if (_width < widget.minWidth) {
      result = widget.minWidth;
    } else if (_width > widget.maxWidth) {
      result = widget.maxWidth;
    } else {
      result = _width;
    }
    widget.controller.value = result;
  }

  void _onDragCancel() {
    _setDragging(false);
  }

  void _onDragEnd(_) {
    widget.onDragEnd?.call(widget.controller.value);
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
                width: 2,
                color: Colors.black,
              );
            },
          ),
        ),
      ),
    );
  }
}

