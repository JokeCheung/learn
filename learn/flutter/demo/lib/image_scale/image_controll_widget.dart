import 'dart:io';
import 'package:demo/image_scale/painter.dart';
import 'package:demo/pop_menu_button/editor_mouse_popup_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'image_controller.dart';
import 'node_image.dart';

/* 图片边框绘制组件*/

class ImageControllerWidget extends StatefulWidget {
  final MyImageController imageController;

  const ImageControllerWidget({
    Key? key,
    required this.imageController,
  }) : super(key: key);

  @override
  State<ImageControllerWidget> createState() => ImageControllerWidgetState();

  static ImageControllerWidgetState of(BuildContext context) {
    return context.findRootAncestorStateOfType<ImageControllerWidgetState>()!;
  }
}

class ImageControllerWidgetState extends State<ImageControllerWidget> {
  Offset? downEventRecord;
  GlobalKey rootKey = GlobalKey();

  MyImageController get imageController => widget.imageController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ImageControllerWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // print("ImageControllerWidget didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    // print("ImageControllerWidget build");

    return Listener(
      onPointerDown: (d) {
        print('Listener onPointerDown');
        downEventRecord = d.localPosition;
      },
      child: SizedBox(
        key: rootKey,
        child: const Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 20,
                height: 20,
                child: ColoredBox(
                  color: Colors.red,
                  child: GestureWidget(),
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
                  child: GestureWidget(),
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
                  child: GestureWidget(),
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
                  child: GestureWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
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
  ImageControllerWidgetState get parentState =>
      ImageControllerWidget.of(context);

  MyImageController get imageController => parentState.imageController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(


      onScaleStart: (details) {
        print("ImageControllerWidget onScaleStart");
        parentState.imageController.checkClickAndSet(
            parentState.downEventRecord!.dx, parentState.downEventRecord!.dy);
      },

      onScaleUpdate: (details) {
        print("ImageControllerWidget onScaleUpdate");
        //只有判断出拖拽点之后才允许出现拖拽框
        if (imageController.clickCtrl != null) {
          print("widget.imageController.clickCtrl != null");
          print("onScaleUpdate 缩放值 details=${details.localFocalPoint}");
          //拿到的是基于控制点范围内的坐标 转换成父容器坐标
          Offset posInSelf = details.localFocalPoint;
          RenderBox parentBox = parentState.rootKey.currentContext
              ?.findRenderObject() as RenderBox;
          RenderBox box = context.findRenderObject() as RenderBox;
          Offset posInRoot = box.localToGlobal(posInSelf, ancestor: parentBox);
          imageController.update(posInRoot.dx, posInRoot.dy);
          return;
        } else {
          print("widget.imageController.clickCtrl == null");
        }
      },

      onScaleEnd: (details) {
        //拖拽角标改变图片大小
        // if (imageController.clickCtrl != null) {
        //   final nodeModel = imageController.bindNodeModel;
        //   final NodeImage? image = imageController.bindImage;
        //   if (nodeModel != null && image != null) {
        //     final width = imageController.width;
        //     final height = imageController.height;
        //     //拦截非法比例
        //     // MyLog.o("拦截 width =$width");
        //     // MyLog.o("拦截 height =$height");
        //
        //     //获取行组件宽度
        //     RenderBox? imageBox = parentState
        //         .selectItemState!.itemContentKey.currentContext
        //         ?.findRenderObject() as RenderBox?;
        //     //获取图片组件图源比例信息
        //     BuildContext imgContext=GlobalObjectKey(parentState.imgSelected!).currentContext!;
        //     ImageItemState imageItemState =ImageItem.of(imgContext)!;
        //     double originalRatio = imageItemState.radio;
        //
        //     if (imageBox != null) {
        //       double containerWidth = imageBox.size.width;
        //       //编辑框宽度
        //       double newWidth = containerWidth - 20;
        //
        //       if (width > newWidth) {
        //         debugPrint("超过容器宽度...拦截 width=$width newWidth=$newWidth");
        //         debugPrint("newWidth=$newWidth");
        //         //MyLog.o("originalRatio=$originalRatio");
        //         final newHeight = newWidth / originalRatio;
        //         //MyLog.o("newHeight=${newHeight}");
        //         imageController.endChanging();
        //         parentState.locateImgPos(size: Size(newWidth, newHeight));
        //         parentState.changeSizeImg(image, newWidth, newHeight);
        //       } else {
        //         final newHeight = width / originalRatio;
        //         debugPrint("不超过容器宽度 不拦截");
        //         imageController.endChanging();
        //         parentState.locateImgPos(
        //             size: imageController.bounds.toRect().size);
        //         parentState.changeSizeImg(image, width, newHeight);
        //       }
        //     }
        //   }
        // }
        //
        // NodeListViewState rootState = NodeListViewState.of(context)!;
        // rootState.scalingImg = false;
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
