import 'package:flutter/material.dart';

class CanvasPageBody extends StatelessWidget {
  const CanvasPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OverflowBox(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: GridPaper(),
          ),
        )
      ],
    );
  }
}
