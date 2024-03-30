import 'package:demo/provider/provider/logo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {

    final model=context.watch<LogoModel>();

    return Card(
      child: Transform.flip(
        flipX: model.flipX,
        flipY: model.flipY,
        child: FlutterLogo(size: model.size,),
      ),
    );
  }
}

