import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

enum OverPosType {
  left,
  right,
}

class ResizeCover extends StatefulWidget {
  static Color dividerNormal = Colors.grey;
  static Color dividerHover = Colors.blue;
  //指针可拖拉操作的区域大小 显示的线条为 dragLineHitWidth/2
  static const dragLineHitWidth = 6.0;

  const ResizeCover({
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

  @override
  State<ResizeCover> createState() => _ResizeCoverState();
}

class _ResizeCoverState extends State<ResizeCover> {
  // Offset offset= Offset.zero;
  double width = 0;

  Widget _buildHitLine() {
    return SizedBox(
      width: ResizeCover.dragLineHitWidth,
      height: double.infinity,
      child: _HitLine(
        mainChild: widget.overPos,
        controller: widget.controller,
        maxWidth: widget.maxWidth,
        minWidth: widget.minWidth,
        onDragEnd: widget.onDragEnd,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget over = _OverChild(
        controller: widget.controller,
        overPosType: widget.overPos,
        maxWidth: widget.maxWidth,
        minWidth: widget.minWidth,
        child: widget.overChild);
    Widget bottom = _BottomChild(child: widget.bottomChild);
    // Widget bottom  = Container();
    MainAxisAlignment holderAlignment;
    List<Widget> holderChildren;
    //可调节面板放在左侧
    // if (widget.overPos == OverPosType.left) {
    //   holderAlignment = MainAxisAlignment.start;
    //   holderChildren = [
    //     over,
    //     _buildHitLine(),
    //   ];
    //   //可调节面板放在右侧
    // } else {
    //   holderAlignment = MainAxisAlignment.end;
    //   holderChildren = [
    //     _buildHitLine(),
    //     over,
    //   ];
    // }

    return Stack(
      children: [
        bottom,
        over,
        Align(
          alignment: Alignment.bottomRight,
          child: MaterialButton(
              onPressed: () {
                print("MaterialButton onPressed");
                if (widget.controller.value.width == 0) {
                  widget.controller.value = ControllerModel(500, false);
                } else {
                  widget.controller.value = ControllerModel(0, false);
                }
              },
              child: const Text(
                "点击按钮",
              )),
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
    required this.overPosType,
    required this.maxWidth,
    required this.minWidth,
  });

  final ValueNotifier<ControllerModel> controller;
  final Widget child;
  final double maxWidth;
  final double minWidth;
  final OverPosType overPosType;

  @override
  Widget build(BuildContext context) {
    // Widget childContent = Stack(
    //   children: [
    //     Row(
    //       children: [
    //
    //         if (overPosType == OverPosType.right)
    //           const SizedBox(
    //             width: ResizeLine.dragLineHitWidth,
    //           ),
    //
    //         (){
    //           //拖拽不执行动画
    //           if (value.drag) {
    //             return SizedBox(
    //               width: value.width,
    //               height: double.infinity,
    //               child: child,
    //             );
    //             //手动展开执行动画
    //           } else {
    //             return AnimatedContainer(
    //               width: value.width,
    //               height: double.infinity,
    //               duration: const Duration(milliseconds: 250),
    //               child: child,
    //             );
    //           }
    //         }(),
    //
    //         if (overPosType == OverPosType.left)
    //           const SizedBox(
    //             width: ResizeLine.dragLineHitWidth,
    //           ),
    //       ],
    //     ),
    //
    //     Align(
    //       alignment: Alignment.topRight,
    //       child: SizedBox(
    //         width: ResizeLine.dragLineHitWidth,
    //         height: double.infinity,
    //         child: _HitLine(
    //           mainChild: overPosType,
    //           controller: controller,
    //           maxWidth: maxWidth,
    //           minWidth: minWidth,
    //         ),
    //       ),
    //     ),
    //     // Align(
    //     //   alignment: Alignment.topRight,
    //     //   child: Container(
    //     //     width: 10,
    //     //     color:Colors.white,
    //     //   ),
    //     // )
    //   ],
    // );
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (BuildContext context, ControllerModel value, Widget? child) {
        print("_OverChild value=${value.drag}");
        //拖拽不执行动画
        if (value.drag) {
          return SizedBox(
            width: value.width,
            height: double.infinity,
            child: Stack(
              children: [
                SizedBox(
                    width: max(0, value.width - ResizeCover.dragLineHitWidth/2),
                    child: child!),
                if (overPosType == OverPosType.left)
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: ResizeCover.dragLineHitWidth,
                      child: _HitLine(
                          controller: controller,
                          maxWidth: maxWidth,
                          minWidth: minWidth),
                    ),
                  ),
                if (overPosType == OverPosType.right)
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: ResizeCover.dragLineHitWidth,
                      child: _HitLine(
                          controller: controller,
                          maxWidth: maxWidth,
                          minWidth: minWidth),
                    ),
                  ),
              ],
            ),
          );
          //手动展开执行动画
        } else {
          return AnimatedContainer(
            width: value.width,
            height: double.infinity,
            duration: const Duration(milliseconds: 250),
            child: Stack(
              children: [
                SizedBox(
                    width: max(0, value.width - ResizeCover.dragLineHitWidth/2),
                    child: child!),
                if (overPosType == OverPosType.left)
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: ResizeCover.dragLineHitWidth,
                      child: _HitLine(
                          controller: controller,
                          maxWidth: maxWidth,
                          minWidth: minWidth),
                    ),
                  ),
                if (overPosType == OverPosType.right)
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: ResizeCover.dragLineHitWidth,
                      child: _HitLine(
                          controller: controller,
                          maxWidth: maxWidth,
                          minWidth: minWidth),
                    ),
                  ),
              ],
            ),
          );
        }
      },
      child: child,
    );
  }
}

class _BottomChild extends StatelessWidget {
  final Widget child;

  const _BottomChild({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class ControllerModel {
  double width;
  bool drag;

  ControllerModel(this.width, this.drag);

  static copy(ControllerModel model) {
    return ControllerModel(model.width, model.drag);
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

class _HitLineState extends State<_HitLine>
    with SingleTickerProviderStateMixin {
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

    widget.controller.value = ControllerModel(result, _isDragging);
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
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: SizedBox(
              width: ResizeCover.dragLineHitWidth / 2,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final compositeColor = ColorUtils.compositeColors(
                    ResizeCover.dividerHover
                        .withOpacity(_controller.value)
                        .value,
                    ResizeCover.dividerNormal.value,
                  );
                  return Container(
                    color: Color(compositeColor),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ColorUtils {
  static int compositeColors(int foreground, int background) {
    int bgAlpha = Color(background).alpha;
    int fgAlpha = Color(foreground).alpha;
    int a = compositeAlpha(fgAlpha, bgAlpha);

    int r = compositeComponent(
        Color(foreground).red, fgAlpha, Color(background).red, bgAlpha, a);
    int g = compositeComponent(
        Color(foreground).green, fgAlpha, Color(background).green, bgAlpha, a);
    int b = compositeComponent(
        Color(foreground).blue, fgAlpha, Color(background).blue, bgAlpha, a);

    return (a << 24) | (r << 16) | (g << 8) | b;
  }

  static int compositeAlpha(int foregroundAlpha, int backgroundAlpha) {
    return 0xFF -
        (((0xFF - backgroundAlpha) * (0xFF - foregroundAlpha)) ~/ 0xFF);
  }

  static int compositeComponent(int fgC, int fgA, int bgC, int bgA, int a) {
    if (a == 0) return 0;
    return ((0xFF * fgC * fgA) + (bgC * bgA * (0xFF - fgA))) ~/ (a * 0xFF);
  }
}
