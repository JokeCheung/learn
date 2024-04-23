/*

import 'package:context_menu/src/context_menu_overlay.dart';
import 'package:context_menu/src/menu_item.dart';
import 'package:flutter/material.dart';

export 'package:context_menu/src/context_menu_overlay.dart';
export 'package:context_menu/src/menu_item.dart';
export 'package:context_menu/src/value/dimens.dart';

void showContextMenu({
  required BuildContext context,
  required List<MenuData> data,

}) {
  final widgets = <Widget>[];
  for (var d in data) {
    widgets.add(MenuItem(text: d.text, onTap: d.onPress, minWidth: 120,));
  }
  final overlay = ContextMenuOverlay.of(context);
  final menuCard = MenuCard(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: widgets,
    ),
  );
  overlay.show(child: menuCard,);
}

void hideContextMenu(BuildContext context) {
  ContextMenuOverlay.of(context).hide();
}


class MenuData{
  const MenuData({required this.text, this.onPress});
  final String text;
  final VoidCallback? onPress;
}*/
