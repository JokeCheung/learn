import 'package:demo/image_scale/painter.dart';
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

  set selectImg(NodeImage? img){
    clearSelectImg();
    _selectImg=img;
  }

  NodeImage? get selectImg=>_selectImg;

  @override
  Widget build(BuildContext context) {

    List<Widget> children=List.generate(1, (index) {
      return const Column(
        children: [
         Item(),
         Divider(),
      ],
    );
    });

    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context,constraints){
          return Container(
            width: constraints.maxWidth/2,
            color: Colors.green.withAlpha(100),
            child: Stack(
              children: [
                Column(
                  key: listContentKey,
                  children: children,
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


  MyImageController? findImageController(){
    if(selectImg==null) return null;
    BuildContext? imageContext=GlobalObjectKey(selectImg!).currentContext;
    if(imageContext!=null){
      ImageViewState state=ImageView.of(imageContext);
      return state.imageController;
    }
    return null;
  }

}
