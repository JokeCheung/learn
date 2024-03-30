import 'package:flutter/material.dart';
import 'image_controller.dart';
import 'dart:io';
import 'main4.dart';


class Item extends StatefulWidget {
  final String imgSrc;
  const Item({Key? key, required this.imgSrc}) : super(key: key);

  @override
  State<Item> createState() => ItemState();
}

class ItemState extends State<Item> {

  static const double headWidth = 50;

  GlobalKey imgKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    TestWidgetState rootState = TestWidget.of(context);
    return Row(
      children:[
        SizedBox(
          width: headWidth,
          height: headWidth,
          child: Container(
            color: Colors.orange,
          ),
        ),

        Expanded(
          child:ImageView(
            imgKey:imgKey,
            imagePath:widget.imgSrc,
          ),
        ),
      ],
    );
  }
}

class ImageView extends StatefulWidget {
  final GlobalKey imgKey;
  final String imagePath;
  const ImageView({super.key, required this.imgKey, required this.imagePath});

  @override
  State<ImageView> createState() => _ImageViewState();
}


class _ImageViewState extends State<ImageView>  {

  late NodeImage image;

  @override
  void initState() {
    super.initState();
    image=NodeImage(widget.imagePath, width: null, height: null);

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
    return  Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          rootState.clickImg(context,widget.imgKey,image);
        },
        child: Image(
          key: widget.imgKey,
          width: image.width?.toDouble(),
          height: image.height?.toDouble(),
          image:  AssetImage(widget.imagePath),
        ),
      ),
    );
  }
}

