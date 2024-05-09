import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'node_image.dart';

class MyImageController extends ImageController with ChangeNotifier {

  Rect? viewBounds;
  MyImageController({this.viewBounds});

  //更新绑定信息
  // @override
  // void updateBind() {
  //   print("MyImageController updateBind...");
  //   if (viewBounds == null){
  //     print("end1");
  //     return;
  //   }
  //   final image = bindImage;
  //   if (image == null){
  //     print("end2");
  //     return clearBind();
  //   }
  //   int width = image.widthNotNull;
  //   int height = image.heightNotNull;
  //   if (width <= 0 || height <= 0) {
  //     print("end3");
  //     return clearBind();
  //   }
  //   setRatio(width, height);
  //   //bounds用于四个控制点的击中测试 && 选中框的绘制
  //   bounds.setLTWH(viewBounds!.left, viewBounds!.top, viewBounds!.width, viewBounds!.height);
  //   print("MyImageController updateBind bounds=$bounds");
  //   updateCtrlBounds();
  // }

  setImgBound(Rect? vb) {
    viewBounds=vb;
    print("setImgBound...$viewBounds");
  }

  @override
  set bindImage(NodeImage? bindImage) {
    super.bindImage = bindImage;
    notifyListeners();
  }

  //清除绑定信息
  @override
  void clearBind() {
    isBindView = false;
    bindImage = null;
    // bindNodeModel = null;
    bounds.reset();
    notifyListeners();
  }
}

class ImageController {

  static const handleSize = 10;
  static const showHandleClip = 5;
  //控制点的位置
  final bounds = MutableRect.zero();
  double _aspectRatio = 0.0;
  double _k = 0;

  final List<MutableRect> ctrlBounds = [
    MutableRect.zero(),
    MutableRect.zero(),
    MutableRect.zero(),
    MutableRect.zero()
  ];
  bool isBindView = false;
  int? _clickCtrl;

  set clickCtrl(int? value) {
    _clickCtrl = (value != null && value >= 0 && value <= 3) ? value : null;
  }
  int? get clickCtrl => _clickCtrl;
  double get width => bounds.width;
  double get height => bounds.height;

  static const _moveColor = Color(0x50888888);
  Color boundsColor = const Color(0xff0168FD);
  final _paint = Paint()
    ..isAntiAlias = true
    ..strokeWidth = 1
    ..color = const Color(0xff0168FD);
  final _paintCtrlRect = Paint()
    ..isAntiAlias = true
    ..strokeWidth = 1
    ..color = Colors.cyanAccent.withAlpha(150);

  // BaseNodeModel? bindNodeModel;
  NodeImage? bindImage;


  /// 绑定节点 && 一张图片
  void bindNodeImage(NodeImage nodeImage) {
    print("ImageController bindNodeImage...");
    bindImage = nodeImage;
    isBindView = true;
    updateBind();
  }

  ///更新绑定信息
  void updateBind() {
    print("ImageController updateBind...");
    final image = bindImage;
    if (image == null) return clearBind();

    final imageBounds = bindImage!.imagesBounds[image.src];
    if (bindImage == null) return clearBind();

    int width = image.widthNotNull;
    int height = image.heightNotNull;
    if (width <= 0 || height <= 0) {
      return clearBind();
    }
    setRatio(width, height);
    bounds.setLTRB(
        imageBounds!.left,
        imageBounds.top,
        imageBounds.right,
        imageBounds.bottom
    );
    updateCtrlBounds();
  }

  setRatio(int width,int height){
    _aspectRatio = width / height;
    _k = height / width;
  }

  void updateCtrlBounds() {
    print("ImageController updateCtrlBounds...");
    final left = bounds.left;
    final top = bounds.top;
    final right = bounds.right;
    final bottom =bounds.bottom;
    ctrlBounds[0].setLTRB(
      left - handleSize,
      top - handleSize,
      left + handleSize,
      top + handleSize,
    );
    ctrlBounds[1].setLTRB(
      right - handleSize,
      top - handleSize,
      right + handleSize,
      top + handleSize,
    );
    ctrlBounds[2].setLTRB(
      right - handleSize,
      bottom - handleSize,
      right + handleSize,
      bottom + handleSize,
    );
    ctrlBounds[3].setLTRB(
      left - handleSize,
      bottom - handleSize,
      left + handleSize,
      bottom + handleSize,
    );

    print("ImageController ctrlBounds=$ctrlBounds");
  }

  //清除绑定信息
  void clearBind() {
    isBindView = false;
    bindImage = null;
    // bindNodeModel = null;
    bounds.reset();

  }

  void draw(Canvas canvas) {
    if (!isBindView) return;
    _paint.style = PaintingStyle.stroke;
   print("画矩形 rect=${bounds.toRect().toString()}");

    canvas.drawRect(bounds.toRect(), _paint);
    _paint.style = PaintingStyle.fill;
    if (_clickCtrl != null) {
      _paint.color = _moveColor;
      canvas.drawRect(bounds.toRect(), _paint);
      _paint.color = boundsColor;
    }
    for (var ctrl in ctrlBounds) {
      // print("画四个点");
      canvas.drawOval(Rect.fromLTRB(
        ctrl.left + showHandleClip,
        ctrl.top + showHandleClip,
        ctrl.right - showHandleClip,
        ctrl.bottom - showHandleClip,
      ), _paint);

      canvas.drawRect(Rect.fromLTRB(
        ctrl.left + showHandleClip,
        ctrl.top + showHandleClip,
        ctrl.right - showHandleClip,
        ctrl.bottom - showHandleClip,
      ),_paintCtrlRect);
    }
    print("ImageController draw...");
  }

  //判断传入坐标落在哪个控制点上
  int checkClickAndSet(double x, double y) {
    print("checkClickAndSet");
    int i = 0;
    for (var ctrl in ctrlBounds) {
      print('第$i个 ctrl=$ctrl');
      print('坐标 x=$x y=$y');
      if (ctrl.contains(x, y)) {
        print('在这个控制点上');
        clickCtrl = i;
        return i;
      }else{
        print('不在');
      }
      i++;
    }
    clickCtrl = null;
    return -1;
  }

  bool updatePoint(double x, double y) {

    print("image updatePoint...");
    final ctrl = clickCtrl;
    if (ctrl == null) return false;
    switch (ctrl) {
      case 0: {
        final a = -1 / _k;
        const b = -1;
        final c = (1 / _k) * bounds.left + bounds.top;
        final distance = (a * x + b * y + c) / sqrt(a * a + b * b);
        final alpha = atan(-1 / _k);
        final dx = distance * sin(alpha);
        final toX = bounds.left + dx;

        if (bounds.right - toX <  NodeImage.minSize) {
          bounds.left = bounds.right - NodeImage.minSize;
        } else {
          bounds.left = toX;
        }
        final width = bounds.width;
        final height = width / _aspectRatio;
        bounds.top = bounds.bottom - height;
        updateCtrlBounds();
      }
      break;
      case 1: {
        final a = 1 / _k;
        const b = -1;
        final c = (-1 / _k) * bounds.right + bounds.top;
        final distance = (a * x + b * y + c) / sqrt(a * a + b * b);
        final alpha = atan(1 / _k);
        final dx = distance * sin(alpha);
        final toX = bounds.right + dx;

        if (toX - bounds.left < NodeImage.minSize) {
          bounds.right = bounds.left + NodeImage.minSize;
        } else {
          bounds.right = toX;
        }
        final width = bounds.width;
        final height = width / _aspectRatio;
        bounds.top = bounds.bottom - height;
        updateCtrlBounds();
      }
      break;
      case 2: {
        final a = -1 / _k;
        const b = -1;
        final c = (1 / _k) * bounds.right + bounds.bottom;
        final distance = (a * x + b * y + c) / sqrt(a * a + b * b);
        final alpha = atan(-1 / _k);
        final dx = distance * sin(alpha);
        final toX = bounds.right + dx;

        if (toX - bounds.left < NodeImage.minSize) {
          bounds.right = bounds.left + NodeImage.minSize;
        } else {
          bounds.right = toX;
        }
        final width = bounds.width;
        final height = width / _aspectRatio;
        bounds.bottom = bounds.top + height;
        updateCtrlBounds();
      }
      break;
      case 3: {
        // 注意这里是水平翻转，不是垂直，k取2状态下的相反数
        final a = 1 / _k;
        const b = -1;
        final c = (-1 / _k) * bounds.left + bounds.bottom;
        final distance = (a * x + b * y + c) / sqrt(a * a + b * b);
        final alpha = atan(1 / _k);
        final dx = distance * sin(alpha);
        final toX = bounds.left + dx;

        if (bounds.right - toX < NodeImage.minSize) {
          bounds.left = bounds.right - NodeImage.minSize;
        } else {
          bounds.left = toX;
        }
        final width = bounds.width;
        final height = width / _aspectRatio;
        bounds.bottom = bounds.top + height;
        updateCtrlBounds();
      }
      break;
      default: {
        return false;
      }
    }
    return true;
  }

  void endChanging() {
    clickCtrl = null;
  }
}


class MutableRect {

  MutableRect(this.left, this.top, this.right, this.bottom);
  MutableRect.zero(): this(0, 0, 0, 0);
  MutableRect.fromLTWH(double left, double top, double width, double height): this(left, top, left + width, top + height);
  double left = 0;
  double top = 0;
  double right = 0;
  double bottom = 0;

  void setLTWH(double left, double top, double width, double height) {
    this.left = left;
    this.top = top;
    right = left + width;
    bottom = top + height;
  }

  void setLTRB(double left, double top, double right, double bottom) {
    this.left = left;
    this.top = top;
    this.right = right;
    this.bottom = bottom;
  }

  void reset() {
    left = 0;
    top = 0;
    right = 0;
    bottom = 0;
  }

  double get centerY {
    return (top + bottom) / 2.0;
  }

  double get centerX {
    return (left + right) / 2.0;
  }

  double get height {
    return (bottom - top);
  }

  double get width {
    return right - left;
  }

  bool contains(double x, double y) {
    return left < right && top < bottom
        && x >= left && x < right && y >= top && y < bottom;
  }

  void translate(double x, double y) {
    left += x;
    right += x;
    top += y;
    bottom += y;
  }

  Rect toRect() {
    return Rect.fromLTRB(left, top, right, bottom);
  }

  void fromRect(Rect rect) {
    left = rect.left;
    top = rect.top;
    right = rect.right;
    bottom = rect.bottom;
  }

  @override
  String toString() {
    return "left:$left top:$top right:$right bottom:$bottom}";
  }
}

