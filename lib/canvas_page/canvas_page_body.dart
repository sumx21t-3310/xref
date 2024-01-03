import 'package:flutter/material.dart';

class CanvasPageBody extends StatelessWidget {
  const CanvasPageBody({
    super.key,
    required this.children,
    required this.visibleGrid,
  });

  final List<Widget> children;
  final bool visibleGrid;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (visibleGrid) ...{
          OverflowBox(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black12,
              child: const GridPaper(
                subdivisions: 5,
                divisions: 1,
                interval: 100,
              ),
            ),
          ),
        },
        ...children
      ],
    );
  }
}
