import 'dart:async';
import 'dart:ui' as ui;
import 'package:demo/image_scale/painter.dart';
import 'package:demo/pop_menu_button/editor_mouse_popup_overlay.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'image_controll_widget.dart';
import 'image_controller.dart';
import 'dart:io';
import 'main0.dart';
import 'node_image.dart';

class Item extends StatefulWidget {
  const Item({
    super.key,
  });

  @override
  State<Item> createState() => ItemState();
}

class ItemState extends State<Item> {
  static const double headWidth = 50;

  GlobalKey imageViewKey = GlobalKey();
  double imgWidth = 100;
  double? imgHeight;
  double? imgRatio;
  double? heightScale;

  // loadImage() async {
  //   var image = Image.asset(imgPath);
  //   Completer<ui.Image> completer = Completer<ui.Image>();
  //   image.image
  //       .resolve(const ImageConfiguration())
  //       .addListener(ImageStreamListener((ImageInfo info, bool _) {
  //     completer.complete(info.image);
  //   }));
  //
  //   ui.Image info = await completer.future;
  //   imgWidth = info.width.toDouble();
  //   imgHeight = info.height.toDouble();
  //   imgRatio = imgWidth! / imgHeight!;
  //   print("加载图片完毕 imgWidth=$imgWidth");
  //   print("加载图片完毕 imgHeight=$imgHeight");
  //   print("加载图片完毕 imgRatio=$imgRatio");
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    // image = NodeImage(imgPath);
    // loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return MeasuredSizeWidget(
      onChange: (size) {
        print("MeasuredSizeWidget onChange size.width=${size.width}");
        imgWidth = size.width / 3;

        //update imageController bounds
        bool selectImg = TestWidget.of(context).selectImg != null;
        if (selectImg) {
          MyImageController imageController =
              TestWidget.of(context).findImageController()!;
          NodeImage image = imageController.bindImage!;
          RenderBox? imgBox = GlobalObjectKey(image)
              .currentContext
              ?.findRenderObject() as RenderBox?;
          if (imgBox == null || !imgBox.hasSize) {
            print("clickImg return");
            return;
          }
          double left = 10;
          double top = 10;
          double width = imgBox.size.width;
          double height = imgBox.size.height;
          print("onChange box width=${width} height=$height");
          MutableRect mutableRect = MutableRect.fromLTWH(left, top, width, height);
          image.imagesBounds.addEntries([MapEntry(image.src, mutableRect)]);
          imageController.updateBind();
        }
        setState(() {});
      },
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageView(
              width: imgWidth,
            ),
            ImageView(
              width: imgWidth,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageView extends StatefulWidget {
  final double width;

  const ImageView({
    super.key,
    required this.width,
  });

  @override
  State<ImageView> createState() => ImageViewState();

  static ImageViewState of(BuildContext context) {
    return context.findAncestorStateOfType<ImageViewState>()!;
  }
}

class ImageViewState extends State<ImageView> {
  static const String imgPath = 'lib/image_scale/assets/image_scale.png';
  MyImageController imageController = MyImageController();
  NodeImage nodeImage = NodeImage(imgPath);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ImageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   RenderBox imgBox=context.findRenderObject() as RenderBox;
    //   Size size=imgBox.size;
    //   image.width=size.width.toInt();
    //   image.height=size.height.toInt();
    //   print("设置图片组件宽 width=${image.width}");
    //   print("设置图片组件宽 height=${image.height}");
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {

    print("ImageView build");

    return ListenableBuilder(
      listenable: imageController,
      builder: (BuildContext context, Widget? child) {
        return Container(
          color: Colors.yellow,
          width: widget.width,
          height: widget.width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    clickImg(context, nodeImage,);
                  },

                  onSecondaryTap: (){
                    clickImg(context, nodeImage,);
                    print("onSecondaryTap...");
                  },

                  child: Container(
                    color: Colors.blue,
                    child: Image(
                      key: GlobalObjectKey(nodeImage),
                      image: AssetImage(nodeImage.src),
                    ),
                  ),
                ),
              ),
              if(imageController.isBindView)
              ImageControllerWidget(
                imageController: imageController,
              ),
            ],
          ),
        );
      },
    );
  }

  void clickImg(
    BuildContext context,
    NodeImage image,
  ) {
    var selectImg=TestWidget.of(context).selectImg;
    if( selectImg != nodeImage){
      RenderBox? imgBox = GlobalObjectKey(nodeImage)
          .currentContext
          ?.findRenderObject() as RenderBox?;
      if (imgBox == null || !imgBox.hasSize) {
        print("clickImg return");
        return;
      }
      double left = 10;
      double top = 10;
      double width = imgBox.size.width;
      double height = imgBox.size.height;
      MutableRect mutableRect = MutableRect.fromLTWH(left, top, width, height);
      image.imagesBounds.addEntries([MapEntry(image.src, mutableRect)]);
      imageController.bindNodeImage(image);
      TestWidget.of(context).selectImg = nodeImage;
      print("image 地址=${image.hashCode}");
    }
  }
}
