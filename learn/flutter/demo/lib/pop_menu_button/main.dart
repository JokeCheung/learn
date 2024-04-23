import 'package:demo/pop_menu_button/select_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'editor_mouse_popup_overlay.dart' as context_menu;
import 'editor_mouse_popup_overlay.dart';

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
  @override
  Widget build(BuildContext context) {
    return EditorMousePopupOverlay(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        body: Center(
          child: Column(
            children: [
              SelectButton(
                text: '1111',
                enable: true,
                callbackClear: () {},
                onTap: () {},
                onMouseEnterOrTap: onMouseEnterOrTap,
                onMouseExit: onMouseExit,
              ),
              SelectButton(
                text: '2222',
                enable: true,
                callbackClear: () {},
                onTap: () {},
                onMouseEnterOrTap: onMouseEnterOrTap,
                onMouseExit: onMouseExit,
              ),
              SelectButton(
                text: '3333',
                enable: true,
                callbackClear: () {},
                onTap: () {},
                onMouseEnterOrTap: onMouseEnterOrTap,
                onMouseExit: onMouseExit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onMouseEnterOrTap(BuildContext context, Rect rect) {
    final widget = MenuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(
            padding: EdgeInsets.zero,
            child: const Text("390*844"),
            onPressed: () {},
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            child: const Text("360*800"),
            onPressed: () {},
          ),
        ],
      ),
    );
    final state = EditorMousePopupOverlay.of(context);
    if (state != null) {
      state.show(
        child: widget,
        menuAlignment: Alignment.bottomCenter,
        menuRectPosition: Rect.fromCenter(
          center: rect.center + const Offset(0, 12),
          width: rect.width,
          height: rect.height,
        ),
        clickNotHideScope: (globalPosition) {
          return rect.contains(globalPosition);
        },
        tag: 'text_align',
      );
    }
  }

  onMouseExit(BuildContext context, PointerExitEvent event) {
    final state = EditorMousePopupOverlay.of(context);
    if (state != null) {
      state.notifyLeftButton();
    }
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(6),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        shadows: const [
          BoxShadow(
              // color: Color(0xff000000),
              color: Color(0x15000000),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
              blurStyle: BlurStyle.normal),
        ],
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
