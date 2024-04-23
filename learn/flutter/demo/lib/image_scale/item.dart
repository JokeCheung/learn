import 'dart:async';
import 'dart:ui' as ui;
import 'package:demo/image_scale/painter.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'controll_widget.dart';
import 'image_controller.dart';
import 'dart:io';
import 'main0.dart';
import 'node_image.dart';

class Item extends StatefulWidget {
  final MyImageController imageController;

  const Item({
    Key? key,
    required this.imageController,
  }) : super(key: key);

  @override
  State<Item> createState() => ItemState();
}

class ItemState extends State<Item> {
  static const double headWidth = 50;
  static const String imgPath = 'lib/image_scale/assets/image_scale.png';
  GlobalKey imgKey = GlobalKey();
  double? imgWidth;
  double? imgHeight;
  double? imgRatio;
  double? heightScale;
  late NodeImage image;

  loadImage() async {
    var image = Image.asset(imgPath);
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));

    ui.Image info = await completer.future;
    imgWidth = info.width.toDouble();
    imgHeight = info.height.toDouble();
    imgRatio = imgWidth! / imgHeight!;
    print("加载图片完毕 imgWidth=$imgWidth");
    print("加载图片完毕 imgHeight=$imgHeight");
    print("加载图片完毕 imgRatio=$imgRatio");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = NodeImage(imgPath);
    // loadImage();
  }

  @override
  Widget build(BuildContext context) {
    TestWidgetState rootState = TestWidget.of(context);
    return Container(
      color: Colors.green.withAlpha(150),
      child: ListenableBuilder(
          listenable: widget.imageController,
          builder: (BuildContext context, Widget? child) {
            return LayoutBuilder(builder: (context, constraints) {
              print("width: constraints.maxWidth=${constraints.maxWidth}");
              print("height: constraints.maxHeight=${constraints.maxHeight}");

              // if (imgRatio != null) {
              //   heightScale = constraints.maxWidth / imgRatio!;
              // }
              // print("加载图片完毕 heightScale=$heightScale");

              Size size = Size.zero;
              if (image.loadDone) {
                heightScale = constraints.maxWidth / image.imgRatio!;
                size = Size(constraints.maxWidth, heightScale!);
              }

              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ImageView(
                      imgKey: imgKey,
                      controller: widget.imageController,
                      imagePath: imgPath,
                      image: image,
                      size: size,
                    ),
                  ),

                  if (widget.imageController.bindImage == image &&
                      image.loadDone)
                    SizedBox(
                      width: size.width,
                      height: size.height,
                      // child: PainterWidget(controller: widget.imageController),
                      child: ControllerWidget(
                        size:size,
                      ),
                    ),
                ],
              );
            });
          }),
    );
  }
}



class ImageView extends StatefulWidget {
  final GlobalKey imgKey;
  final String imagePath;
  final NodeImage image;
  final Size size;
  final MyImageController controller;

  const ImageView(
      {super.key,
      required this.imgKey,
      required this.imagePath,
      required this.controller,
      required this.image,
      required this.size});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  MyImageController get imageController => widget.controller;

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
    TestWidgetState rootState = TestWidget.of(context);
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            rootState.clickImg(context, widget.image, widget.size);
          },
          child: Image(
            key: widget.imgKey,
            image: AssetImage(widget.imagePath),
          ),
        ),
      ],
    );
  }
}
