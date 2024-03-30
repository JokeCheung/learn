import 'dart:io';

import 'package:flutter/material.dart';


import 'image_controller.dart';
import 'main4.dart';

class PainterWidget extends StatefulWidget {
  final ImgSelectLocator locator;
  final MyImageController controller;

  const PainterWidget({Key? key, required this.controller, required this.locator}) : super(key: key);

  @override
  State<PainterWidget> createState() => _PainterWidgetState();
}

class _PainterWidgetState extends State<PainterWidget> {


  MyImageController get controller=>widget.controller;
  ImgSelectLocator get locator=>widget.locator;
  double get posLeft=>locator.imgRect.left;
  double get posTop=>locator.imgRect.top;
  double get posWidth=>locator.imgRect.width;
  double get posHeight=>locator.imgRect.height;

  void _onImgChange() {
    setState(() {
      print("ImageControllerWidget setSate");
    });
  }

  @override
  void initState() {
    super.initState();
    widget.locator.addListener(_onImgChange);
    widget.controller.addListener(_onImgChange);
  }

  @override
  void dispose() {
    super.dispose();
    widget.locator.removeListener(_onImgChange);
    widget.controller.addListener(_onImgChange);
  }

  @override
  Widget build(BuildContext context) {

    print("build posLeft=$posLeft");
    print("build posTop=$posTop");
    print("build posWidth=$posWidth");
    print("build posHeight=$posHeight");

    TestWidgetState rootState = TestWidget.of(context);

    return Positioned(
      left: posLeft,
      top: posTop,
      child: SizedBox(
        width: posWidth,
        height: posHeight,
        child: Container(
          color: Color(0x88FF9800),
          child: CustomPaint(
            painter: BoxPainter(controller),
            child: GestureDetector(
              onScaleStart: (details) {
                print("onScaleStart clickCtrl=${rootState.imageController.clickCtrl}");
                Offset locationDown = details.localFocalPoint;
                rootState.imageController
                    .checkClickAndSet(locationDown.dx, locationDown.dy);
                print("onScaleStart clickCtrl=${rootState.imageController.clickCtrl}");
              },

              onScaleUpdate: (details) {
                //只有判断出拖拽点之后才允许出现拖拽框
                if (rootState.imageController.clickCtrl != null) {
                  // MyLog.o("onScaleUpdate 缩放值 details=${details.localFocalPoint}");
                  Offset offset = details.localFocalPoint;
                  rootState.imageController.updatePoint(offset.dx, offset.dy);
                  rootState.setState(() {});
                  return;
                }else{
                  print("rootState.imageController.clickCtrl == null");
                }
              },

              onScaleEnd: (details) {
                //拖拽角标改变图片大小
                if (rootState.imageController.clickCtrl != null) {
                  final NodeImage? image = rootState.imageController.bindImage;
                  if ( image != null) {
                    final width = rootState.imageController.width;
                    final height = rootState.imageController.height;
                    if(rootState.imgSelectKey==null) return;
                    //获取整个列表的宽度
                    RenderBox? imageBox = rootState.imgSelectKey!.currentContext
                        ?.findRenderObject() as RenderBox?;
                    if (imageBox != null) {

                      double containerWidth = imageBox.size.width;
                      //图片可以分配到的宽度
                      double newWidth = containerWidth - TestWidgetState.padding * 2 - 50;
                      print("图片可以分配到的宽度:$newWidth");
                      double originalRatio = 1;
                      FileImage fileImage = FileImage(File(image.src));
                      final imageStream = fileImage.resolve(const ImageConfiguration());
                      ImageStreamListener? imageStreamListener;

                      imageStreamListener = ImageStreamListener((imageInfo, synchronousCall) {
                        if (imageStreamListener != null) {
                          imageStream.removeListener(imageStreamListener);
                        }
                        var width = imageInfo.image.width;
                        var height = imageInfo.image.height;
                        originalRatio = width / height.toDouble();
                        imageInfo.image.dispose();
                      }, onError: (e, s) {});
                      imageStream.addListener(imageStreamListener);

                      if (width > newWidth) {
                        debugPrint("超过容器宽度...拦截 width=$width newWidth=$newWidth");
                        debugPrint("newWidth=$newWidth");
                        //MyLog.o("originalRatio=$originalRatio");
                        final newHeight = newWidth / originalRatio;
                        //MyLog.o("newHeight=${newHeight}");
                        rootState.imageController.endChanging();
                        rootState.changeSizeImg(image, newWidth, newHeight);
                      } else {
                        final newHeight = width / originalRatio;
                        debugPrint("不超过容器宽度 不拦截");
                        double radio = image.widthNotNull / image.heightNotNull;
                        rootState.imageController.endChanging();
                        rootState.changeSizeImg(image, width, newHeight);
                      }
                    }
                  }
                }
              },
            ),
            // child: Container(),
          ),
        ),
      ),
    );
  }
}


class BoxPainter extends CustomPainter{

  MyImageController controller;
  BoxPainter(this.controller,);


  @override
  void paint(Canvas canvas, Size size) {
    if (controller.bindImage != null) {
      controller.draw(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
