import 'package:demo/image_scale/painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'image_controller.dart';
import 'item.dart';
import 'node_image.dart';

void main() {
  // debugPaintSizeEnabled=true;
  runApp(const MyApp());
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
      home: Scaffold(
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
    );
  }
}

///////////////////////////////////////////Page////////////////////////////////////

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
  GlobalKey listContentKey = GlobalKey();

  NodeImage? _selectImg;

  set selectImg(NodeImage? img) {
    clearSelectImg();
    _selectImg = img;
    setState(() {});
  }

  NodeImage? get selectImg => _selectImg;
  GlobalKey rootKey = GlobalKey();

  ScrollController scrollController=ScrollController();

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.generate(30, (index) {
      return const Stack(
        children: [
          Column(
            children: [
              Item(),
              Divider(),
            ],
          ),
        ],
      );
    });

    return SingleChildScrollView(
      controller: scrollController,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth / 2,
            color: Colors.white,
            child: Stack(
              key: rootKey,
              children: [
                Column(
                  key: listContentKey,
                  children: children,
                ),
                if (selectImg != null)
                  ListenableBuilder(
                    listenable: findImageController()!,
                    builder: (context, child) {
                      print("ListenableBuilder build");
                      return CustomPaint(
                        painter: SelectBoxPainter(
                          calculatePosInRoot(),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  changeSizeImg(NodeImage image, double w, double h) {
    image.width = w.toInt();
    image.height = h.toInt();
    setState(() {});
  }

  clearSelectImg() {
    findImageController()?.clearBind();
  }

  MyImageController? findImageController() {
    if (selectImg == null) return null;
    BuildContext? imageContext = GlobalObjectKey(selectImg!).currentContext;
    if (imageContext != null) {
      ImageViewState state = ImageView.of(imageContext);
      return state.imageController;
    }
    return null;
  }

  Rect? calculatePosInRoot() {
    MyImageController? controller = findImageController();
    if (controller == null) return null;
    RenderBox? imageBox = GlobalObjectKey(selectImg!)
        .currentContext!
        .findRenderObject() as RenderBox?;
    RenderBox? rootBox =
        rootKey.currentContext!.findRenderObject() as RenderBox?;
    if (imageBox != null) {
      Offset global = imageBox.localToGlobal(Offset.zero, ancestor: rootBox!);
      double left = global.dx;
      double top = global.dy;
      Rect result =
          Rect.fromLTWH(left, top, controller.width, controller.height);
      print("rect=${result}");
      return result;
    }
    return null;
  }
}
