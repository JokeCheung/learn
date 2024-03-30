import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'logo_model.dart';

class ControllerPanel extends StatelessWidget {
  const ControllerPanel({super.key});

  @override
  Widget build(BuildContext context) {

    final model=context.watch<LogoModel>();

    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("flipX:"),
              Switch(value: model.flipX, onChanged: (value)=>model.flipX=value),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("flipY:"),
              Switch(value: model.flipY, onChanged: (value)=>model.flipY=value),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Size:"),
              Slider(min: 50,
                  max: 500,
                  value: model.size, onChanged: (value)=>model.size=value),
            ],
          )
        ],
      ),
    );
  }
}

