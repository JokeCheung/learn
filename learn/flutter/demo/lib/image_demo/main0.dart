import 'package:demo/image_demo/painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'image_controller.dart';
import 'item.dart';
import 'node_image.dart';

void main() {
  // debugPaintSizeEnabled=true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<TestWidgetState> listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              RenderBox? rootBox =
                  listKey.currentContext?.findRenderObject() as RenderBox?;
              if (rootBox != null) {
                double containerWidth = rootBox.size.width;
                //图片可以分配到的宽度
                double newWidth = containerWidth -
                    TestWidgetState.padding * 2 -
                    ItemState.headWidth;
                print("图片可以分配到的宽度:$newWidth");
              }
            },
          ),
          backgroundColor: Colors.red,
          body: Align(
            alignment: Alignment.topCenter,
            child: TestWidget(
              key: listKey,
            ),
          ),
        ),
        onTap: () {
          listKey.currentState?.imageController.clearBind();
          print("outer tap");
        },
      ),
    );
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  State<TestWidget> createState() => TestWidgetState();

  static TestWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<TestWidgetState>()!;
  }
}

//默认最大缩放至夫容器宽度 自定义缩放则会存入宽高数据

class TestWidgetState extends State<TestWidget> {
  static const double padding = 15;

  MyImageController imageController = MyImageController();

  GlobalKey listContentKey = GlobalKey();
  GlobalKey? imgSelectKey;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 300,
        color: Colors.green.withAlpha(100),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Column(
                key: listContentKey,
                children: [
                  Item(
                    imageController: imageController,
                  ),
                  SizedBox(
                    height: 2,
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                  Item(
                    imageController: imageController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  changeSizeImg(NodeImage image, double w, double h) {
    image.width = w.toInt();
    image.height = h.toInt();
    setState(() {});
  }

  void clickImg(BuildContext context, NodeImage image,Size scale) {
    print("onTap");

    RenderBox? itemBox = context.findRenderObject() as RenderBox?;
    // RenderBox? imgBox =
    //     imgSelectKey!.currentContext?.findRenderObject() as RenderBox?;
    RenderBox? listBox =
        listContentKey.currentContext?.findRenderObject() as RenderBox?;
    // if (imgBox == null || listBox == null || itemBox == null) {
    //   print("return掉了");
    //   return;
    // }
    //TestWidget->Column->Image
    //          ->listBox->imgBox
    // Offset imgPosInList = imgBox.localToGlobal(Offset.zero, ancestor: listBox);
    // Offset itemPosInList =
    // itemBox.localToGlobal(Offset.zero, ancestor: listBox);
    // Offset imgPosInItem = imgBox.localToGlobal(Offset.zero, ancestor: itemBox);
    //选中框定位区域参数 坐标基于Column
    //图片自身区域参数 坐标基于Image
    double left = 10;
    double top = 10;
    double right = scale.width-10;
    double bottom = scale.height-10;
    Rect viewBounds = Rect.fromLTWH(left, top, right, bottom);
    imageController.setImgBound(viewBounds);
    imageController.bindNodeImage(image);

    print("image 地址=${image.hashCode}");
  }
}
