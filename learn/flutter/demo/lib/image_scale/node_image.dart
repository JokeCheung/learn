import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'image_controller.dart';


class NodeImage {
  static const imageDefaultSize = 230;
  static const minSize = 16;

  Map<String, MutableRect> imagesBounds = {};

  String src;
  int? width;
  int? height;
  double? imgRatio;
  bool loadDone=false;
  //默认图片大小
  int srcWidth=100;
  int srcHeight=100;

  int get widthNotNull => width ?? srcWidth;
  int get heightNotNull => height ?? srcHeight;

  NodeImage(this.src,{this.width,this.height}){
    loadImage();
  }

  loadImage() async {
    print("开始加载图片 time=${DateTime.now().millisecondsSinceEpoch}");
    var image = Image.asset(src);
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));

    ui.Image info = await completer.future;
    width = info.width;
    height = info.height;
    imgRatio = width! / height!;
    print("加载图片完毕 imgWidth=$width");
    print("加载图片完毕 imgHeight=$height");
    print("加载图片完毕 imgRatio=$imgRatio");
    print("结束加载图片 time=${DateTime.now().millisecondsSinceEpoch}");
    loadDone=true;
  }

  // static Point<int> formatSize(int srcWidth, int srcHeight) {
  //   final ratio = srcWidth / srcHeight;
  //   int width = srcWidth;
  //   int height = srcHeight;
  //   if (srcWidth > NodeImage.imageDefaultSize) {
  //     width = NodeImage.imageDefaultSize;
  //     height = width ~/ ratio;
  //   }
  //   if (srcHeight > NodeImage.imageDefaultSize) {
  //     height = NodeImage.imageDefaultSize;
  //     width = (height * ratio).toInt();
  //   }
  //   return Point(width, height);
  // }

  // static NodeImage buildFromSrc(String src, int srcWidth, int srcHeight) {
  //   final newSize = formatSize(srcWidth, srcHeight);
  //   return NodeImage(src, width: newSize.x, height: newSize.y);
  // }

  NodeImage copy() {
    return NodeImage(
      src,
    );
  }

// @override
// bool operator ==(Object other) {
//   return other is NodeImage
//       && runtimeType == other.runtimeType
//       && src == other.src
//       && width == other.width
//       && height == other.height;
//   // return super == other;
// }

//
// @override
// int get hashCode => Object.hash(src, width, height);

}
