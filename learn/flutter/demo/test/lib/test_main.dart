import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  bool enable = true;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      print("addListener");
      // focusNode.unfocus();
      //  if(controller.text.isNotEmpty){
      //    enable=false;
      //    setState(() {});
      //  }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          enable = false;
          setState(() {});
        },
      ),
      // body: Center(
      //   child: Container(
      //     width: 500,
      //     color: Colors.lightGreenAccent,
      //     child: TextField(
      //       focusNode: focusNode,
      //       controller: controller,
      //       enabled: enable,
      //     ),
      //   ),
      // ),
      body: Stack(
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Container(
              color: Colors.black,
            ),
          ),
           SizedBox(
             width: 500,
             height: 500,
             child: CustomPaint(
               child: Wrap(
                 children:[
                   ChangeSizeWidget(
                     child: Container(
                       color: Colors.blue.withAlpha(80),
                     ),
                   ),
                 ],
               ),
             ),
           ),
        ],
      ),
    );
  }
}

//Image & Proto Select Widget
class ChangeSizeWidget extends StatefulWidget {
  // final ChangeSizeController controller;
  final Widget child;

  const ChangeSizeWidget({
    Key? key,
    // required this.controller,
    required this.child,
  }) : super(key: key);

  @override
  State<ChangeSizeWidget> createState() => ChangeSizeWidgetState();

  static ChangeSizeWidgetState of(BuildContext context) {
    return context.findRootAncestorStateOfType<ChangeSizeWidgetState>()!;
  }
}

class ChangeSizeWidgetState extends State<ChangeSizeWidget> {
  GlobalKey rootKey = GlobalKey();

  // ChangeSizeController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChangeSizeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // print("ImageControllerWidget build");

    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 20,
            height: 20,
            child: ColoredBox(
              color: Colors.red,
              child: const GestureWidget(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 20,
            height: 20,
            child: ColoredBox(
              color: Colors.yellow,
              child: const GestureWidget(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: 20,
            height: 20,
            child: ColoredBox(
              color: Colors.green,
              child: const GestureWidget(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
            width: 20,
            height: 20,
            child: ColoredBox(
              color: Colors.purple,
              child: const GestureWidget(),
            ),
          ),
        ),

        // GestureDetector(
        //   onTap: (){
        //     print("object tap");
        //   },
        //   child: SizedBox.expand(
        //     child: CustomPaint(
        //       painter: SelectBoxPainter(
        //         controller: controller,
        //       ),
        //     ),
        //   ),
        // ),
        widget.child,
      ],
    );
  }

//确认删除弹框
// deleteDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (_) {
//       return AlertDialog(
//         content: GestureDetector(
//           child: const Text(
//             "Delete",
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.normal,
//             ),
//           ),
//           onTap: () {
//             NodeListViewState rootState = NodeListViewState.of(context)!;
//             rootState.selectItemState!.clickDeleteCallback(widget.position);
//             Navigator.of(context).pop();
//           },
//         ),
//       );
//     },
//   );
// }
}

class GestureWidget extends StatefulWidget {
  const GestureWidget({super.key});

  @override
  State<GestureWidget> createState() => _GestureWidgetState();
}

class _GestureWidgetState extends State<GestureWidget> {
  ChangeSizeWidgetState get parentState => ChangeSizeWidget.of(context);

  // NodeListViewState get rootState => NodeListViewState.of(context)!;
  //
  // ChangeSizeController get controller => parentState.controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        print("GestureWidget onScaleStart");
        // Offset posInStack = Offset(
        //     rootState.downEventRecord!.dx, rootState.downEventRecord!.dy);
        // parentState.controller.checkClickAndSet(posInStack.dx, posInStack.dy);
      },

      onScaleUpdate: (details) {
        //只有判断出拖拽点之后才允许出现拖拽框
        // if (controller.clickCtrl != null) {
        //   print("widget.imageController.clickCtrl != null");
        //   print("onScaleUpdate 缩放值 details=${details.localFocalPoint}");
        //   Offset posInSelf = details.localFocalPoint;
        //   RenderBox parentBox = rootState.drawImgStackKey.currentContext
        //       ?.findRenderObject() as RenderBox;
        //   RenderBox box = context.findRenderObject() as RenderBox;
        //   Offset posInRoot = box.localToGlobal(posInSelf, ancestor: parentBox);
        //   controller.update(posInRoot.dx, posInRoot.dy);
        //   // NodeListViewState state = NodeListViewState.of(context)!;
        //   // state.updateSizeChangeWidget();
        //   return;
        // } else {
        //   print("widget.imageController.clickCtrl == null");
        // }
      },

      onScaleEnd: (details) {
        // NodeListViewState rootState = NodeListViewState.of(context)!;
        //
        // //拖拽角标改变图片大小
        // if (controller.clickCtrl != null) {
        //   final ChangeSizeBase? element = controller.element;
        //   if (element != null) {
        //     final width = controller.width;
        //     final height = controller.height;
        //     //获取行组件宽度
        //     RenderBox? imageBox = rootState
        //         .selectItemState!.itemContentKey.currentContext
        //         ?.findRenderObject() as RenderBox?;
        //     //获取图片组件图源比例信息
        //     double originalRatio = controller.width / controller.height;
        //
        //     if (imageBox != null) {
        //       double containerWidth = imageBox.size.width;
        //       //编辑框宽度
        //       double newWidth = containerWidth - 20;
        //       if (width > newWidth) {
        //         final newHeight = newWidth / originalRatio;
        //         controller.endChanging();
        //         controller.element!.changeSize(newWidth, newHeight);
        //       } else {
        //         controller.endChanging();
        //         controller.element!.changeSize(width, height);
        //       }
        //     }
        //   }
        // }
        // rootState.scalingImg = false;
        // // controller.updateBind(update: true);
        // print("onScaleEnd 执行完毕！");
      },

      // onLongPress: () {
      //   deleteDialog(context);
      // },
      //
      // onTap: () {
      //   print("点击图片！！！！！！！！！！！！！！！");
      //   //击中测试获取对应位置的ImageViewBox
      //   hitTest(downEventRecord, (p0) => null);
      //
      //   // ItemViewState? itemViewState = rootState.selectItemState;
      //   // rootState.selectItemState!.clickCallback(image, true);
      // },
      //
      // onSecondaryTapUp: (details) {
      //   rootState.selectItemState!.clickCallback(position, true);
      //   showContextMenu(context: context, data: [
      //     MenuData(
      //         text: "Copy",
      //         onPress: () {
      //           rootState.selectItemState!.clickCopyCallback();
      //         }),
      //     MenuData(
      //         text: "Save as",
      //         onPress: () {
      //           rootState.selectItemState!.clickSaveAsCallback();
      //         }),
      //     MenuData(
      //         text: "Delete",
      //         onPress: () {
      //           rootState.selectItemState!.clickDeleteCallback();
      //         }),
      //   ]);
      // },
    );
  }
}

// class SelectBoxPainter extends CustomPainter {
//   ChangeSizeController controller;
//
//   SelectBoxPainter({required this.controller});
//
//   Paint paintBounds = Paint()
//     ..color = Colors.blue
//     ..strokeWidth = 2
//     ..style = PaintingStyle.stroke
//     ..isAntiAlias = true;
//
//   Paint paintConner = Paint()
//     ..color = Colors.blue
//     ..strokeWidth = 2
//     ..style = PaintingStyle.fill
//     ..isAntiAlias = true;
//
//   final List<MutableRect> ctrlBounds = [
//     MutableRect.zero(),
//     MutableRect.zero(),
//     MutableRect.zero(),
//     MutableRect.zero()
//   ];
//
//   static const handleSize = 10;
//   static const showHandleClip = 5;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     print("SelectBoxPainter size=$size");
//     controller.draw(canvas);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
//
