import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EditorMousePopupOverlay extends StatefulWidget {
  const EditorMousePopupOverlay({Key? key, required this.child, this.onTagChange}) : super(key: key);

  final Widget child;
  final void Function(String? tag)? onTagChange;

  @override
  State<StatefulWidget> createState() => EditorMousePopupOverlayState();

  static EditorMousePopupOverlayState of(BuildContext context) {
    return context.findAncestorStateOfType<EditorMousePopupOverlayState>()!;
  }
}

class EditorMousePopupOverlayState extends State<EditorMousePopupOverlay> with TickerProviderStateMixin {
  static const marginEdge = 10.0; // 四周留一点边距
  Widget? _currentMenu;
  Size _menuSize = Size.zero;
  Offset? _menuPosition;
  Alignment? _menuAlignment;// 相对于_menuPosition的Align
  Alignment? _buttonAlignment;
  bool Function(Offset globalPosition)? _clickNotHideScope; // 点击某一个外部区域不取消菜单，一般用于点击菜单按钮
  final _tagController = ValueNotifier<String?>(null);
  set tag(String? value) {
    _tagController.value = value;
    widget.onTagChange?.call(value);
  }
  String? get tag => _tagController.value;

  Size? _parentSize;
  Rect _mousePos = Rect.zero; // 鼠标点击的坐标，具有宽高，弹出菜单将避开此范围显示
  Timer? dismissTimer;

  double currentAnimationMargin = 0;
  double transparent = 0.0;
  AnimationController? _animationController;
  static const double animationAllMargin = 0;
  static const animateDuration = Duration(milliseconds: 100);

  static double _calculateMaxMenuHeight(Size parentSize, Rect mousePos, Alignment menuAlignment, Alignment buttonAlignment) {
    // Step 1. 求Button上经过Alignment后的点坐标
    final y = mousePos.center.dy + mousePos.height / 2.0 * buttonAlignment.y;

    // Step 2. 计算Menu上经过Alignment后的点所在百分比位置，该点在Menu顶部为0%，底部为100%，留意0%的情况别作为除数，
    final menuYProgress = 1.0 - (menuAlignment.y + 1) / 2.0;

    // Step 3. 计算正向布局时的不越界的MenuHeight
    var menuHeight = y / menuYProgress; // 在当前Alignment下撑满顶部的menuHeight。（注意可能底部会越界）
    if (menuHeight < 0 || menuHeight.isInfinite || menuHeight > parentSize.height) {
      menuHeight = (parentSize.height - y) / (1 - menuYProgress); // 在当前Alignment下撑满底部的menuHeight。
    }
    // 避免最后用max取到无穷值
    if (!(menuHeight.isFinite && menuHeight > 0)) {
      menuHeight = 0;
    }

    // Step 4. 计算反向布局（两个Alignment都反过来，如原来菜单往下弹出，改为往上弹出）时不越界的menuHeight
    final yRevert =  mousePos.center.dy - mousePos.height / 2.0 * buttonAlignment.y;
    var menuHeightRevert = yRevert / (1 - menuYProgress);
    if (menuHeightRevert < 0 || menuHeightRevert.isInfinite || menuHeightRevert > parentSize.height) {
      menuHeightRevert = (parentSize.height - yRevert) / menuYProgress;
    }
    if (!(menuHeightRevert.isFinite && menuHeightRevert > 0)) {
      menuHeightRevert = 0;
    }

    var result = max(menuHeight, menuHeightRevert);
    if (result < 0) {
      print('EditorMousePopupOverlayState _calculateMaxMenuHeight:${parentSize.height}');
    }

    // 留一点边距
    if (result > marginEdge) {
      result -= marginEdge;
    }

    return max(0, result);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        // 如果窗口大小改变则隐藏菜单
        _nullMenuIfOverlayWasResized(constraints);
        final menuPosition = _menuPosition;
        final menuAlignment = _menuAlignment ?? Alignment.bottomRight;
        final buttonAlignment = _buttonAlignment ?? menuAlignment;
        final parentSize = _parentSize ?? Size.zero;
        Offset menuPos;
        double? maxHeightForMenu;
        if (menuPosition == null) {
          maxHeightForMenu = _calculateMaxMenuHeight(parentSize, _mousePos, menuAlignment, buttonAlignment);
          // 相对_mosPos中心的偏移
          double dx = 0;
          // double dy = currentAnimationMargin;
          double dy = animationAllMargin;

          final xProgress = (1.0 - menuAlignment.x) / 2.0; // width * xProgress可以获得Align后左边长度
          final yProgress = (1.0 - menuAlignment.y) / 2.0;
          dx -= _menuSize.width * xProgress;
          dy -= _menuSize.height * yProgress;

          dx += _mousePos.width / 2.0 * buttonAlignment.x;
          dy += _mousePos.height / 2.0 * buttonAlignment.y;

          // 左右超出边界，轻微平移挪到屏幕内
          if (_mousePos.center.dx + dx + _menuSize.width > (parentSize.width - marginEdge)) {
            dx = (parentSize.width - marginEdge) - _menuSize.width - _mousePos.center.dx;
          } else if (_mousePos.center.dx + dx < marginEdge) {
            dx = marginEdge - _mousePos.center.dx;
          }

          // 往下超出边界，改为往上弹出，（暂时简单处理）
          if (_mousePos.center.dy + dy + _menuSize.height > parentSize.height) {
            dy = animationAllMargin;
            dy -= _menuSize.height * (1 - yProgress);
            dy += _mousePos.height / 2.0 * buttonAlignment.y * -1;
          } else if (_mousePos.center.dy + dy < 0) {
            dy = animationAllMargin;
            dy -= _menuSize.height * (1 - yProgress);
            dy += _mousePos.height / 2.0 * buttonAlignment.y * -1;
          }
          menuPos = _mousePos.center + Offset(dx, dy);
        } else {
          menuPos = menuPosition;
        }

        Widget? menuToShow = _currentMenu;
        return Listener(
          onPointerDown: (e) {
            if (menuToShow != null) {
              if (e.localPosition.dx <= menuPos.dx ||
                  e.localPosition.dx > menuPos.dx + _menuSize.width ||
                  e.localPosition.dy <= menuPos.dy ||
                  e.localPosition.dy > menuPos.dy + _menuSize.height) {
                //_mousePos = e.localPosition;
                if (_clickNotHideScope?.call(e.position) != true) {
                  hide();
                }
              }
            } else {
              _mousePos = Rect.fromCenter(center: e.localPosition, width: 0, height: 0);
            }
          },
          child: Stack(
            children: [
              ValueListenableBuilder(
                valueListenable: _tagController,
                builder: (context, tag, child) {
                  return EditorMousePopupTagProvider(
                    tag: tag,
                    child: widget.child,
                  );
                },
              ),
              if (menuToShow != null)
                Transform.translate(
                  offset: menuPos,
                  child: Opacity(
                    opacity: _menuSize != Size.zero ? transparent : 0,
                    // Use a measure size widget so we can offset the child properly
                    child: MeasuredSizeWidget(
                      key: ObjectKey(menuToShow),
                      onChange: _handleMenuSizeChanged,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: maxHeightForMenu ?? double.infinity,
                        ),
                        child: MouseRegion(
                          onEnter: (d) {
                            dismissTimer?.cancel();
                          },
                          // onExit: (d) {
                          //   notifyLeftButton();
                          // },
                          child: menuToShow,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void show({
    required String tag,
    required Widget child,
    Offset? menuPosition, // Deprecated
    Rect? menuRectPosition, // 自动避开这个区域显示
    Alignment menuAlignment = Alignment.bottomLeft,
    Alignment? buttonAlignment,
    bool Function(Offset offset)? clickNotHideScope,
  }) {
   // print("show1");
    dismissTimer?.cancel();
    if (tag == this.tag) {
     // print("show2");
      return;
    }
    //print("show3");
    Rect? menuRect;
    if (menuPosition != null) {
      final renderObject = context.findRenderObject();
      if (renderObject is RenderBox) {
        menuPosition = renderObject.globalToLocal(menuPosition);
        menuRect = Rect.fromCenter(center: menuPosition, width: 0, height: 0);
      }
    } else  if (menuRectPosition != null) {
      final renderObject = context.findRenderObject();
      if (renderObject is RenderBox) {
        Offset leftTop = renderObject.globalToLocal(menuRectPosition.topLeft);
        Offset rightBottom = renderObject.globalToLocal(menuRectPosition.bottomRight);
        menuRect = Rect.fromLTRB(leftTop.dx, leftTop.dy, rightBottom.dx, rightBottom.dy);
      }
    }
    setState(() {
      _menuSize = Size.zero;
      _currentMenu = child;
      // _menuPosition = menuPosition;
      if (menuRect != null) {
        _mousePos = menuRect;
      }
      _clickNotHideScope = clickNotHideScope;
      _menuAlignment = menuAlignment;
      _buttonAlignment = buttonAlignment ?? menuAlignment;
      this.tag = tag;
    });
  }

  void notifyLeftButton() {
    dismissTimer = Timer(const Duration(milliseconds: 250), () {
      hide();
    });
  }

  void hide() {
    if (isHidingAnim) return;
    _startDismissAnimation();
  }

  void _clearMenu() => setState(() {
    _currentMenu = null;
    _menuPosition = null;
    _menuAlignment = Alignment.topLeft;
    _buttonAlignment = null;
    tag = null;
  });

  void _handleMenuSizeChanged(Size value) {
    // hide();
    // print("_handleMenuSizeChanged");
    _menuSize = value;
    _startShowAnimation();
  }

  void _startShowAnimation() {
    _startAnimation(0.0, 1.0);
  }

  var isHidingAnim = false;
  void _startDismissAnimation() {
    isHidingAnim = true;
    _startAnimation(1.0, 0.0, (state) {
      isHidingAnim = false;
      if (state == AnimationStatus.completed) {
        _clearMenu();
      } else if (state == AnimationStatus.dismissed) {
        _clearMenu();
      }
    });
  }

  void _startAnimation(double begin, double end, [AnimationStatusListener? listener]) {
    _stopAnimation();
    final flingYController = AnimationController(vsync: this);
    flingYController.duration = animateDuration;
    flingYController.drive(CurveTween(curve: Curves.ease));
    final tweenY = Tween<double>(begin: begin, end: end);
    Animation<double> animationY = tweenY.animate(flingYController);
    animationY.addListener(() {
      currentAnimationMargin = animationAllMargin * animationY.value;
      transparent = animationY.value;
      setState(() {});
    });
    if (listener != null) {
      animationY.addStatusListener(listener);
    }
    _animationController = flingYController;
    flingYController.forward();
  }

  void _stopAnimation() {
    _animationController?.stop();
  }

  void _nullMenuIfOverlayWasResized(BoxConstraints constraints) {
    final size = constraints.biggest;
    bool appWasResized = size != _parentSize;
    if (appWasResized) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _clearMenu();
      });
      // _currentMenu = null;
    }
    _parentSize = size;
  }

  @override
  void dispose() {
    _stopAnimation();
    super.dispose();
  }
}

class MeasuredSizeWidget extends SingleChildRenderObjectWidget {
  const MeasuredSizeWidget(
      {Key? key, required this.onChange, required Widget child})
      : super(key: key, child: child);
  final void Function(Size size) onChange;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _MeasureSizeRenderObject(onChange);
}

class _MeasureSizeRenderObject extends RenderProxyBox {
  _MeasureSizeRenderObject(this.onChange);

  void Function(Size size) onChange;

  Size? _prevSize;

  @override
  void performLayout() {
    super.performLayout();
    Size newSize = child?.size ?? Size.zero;
    if (_prevSize == newSize) {
      return;
    }
    _prevSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) => onChange(newSize));
  }
}

class EditorMousePopupTagProvider extends InheritedWidget {

  const EditorMousePopupTagProvider({
    super.key,
    required this.tag,
    required super.child,
  });
  final String? tag;

  static EditorMousePopupTagProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<EditorMousePopupTagProvider>()!;
  }

  @override
  bool updateShouldNotify(EditorMousePopupTagProvider oldWidget) {
    return oldWidget.tag != tag;
  }

}

