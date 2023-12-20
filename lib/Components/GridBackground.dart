import 'package:flutter/material.dart';

class GridBackground extends StatelessWidget {
  GridBackground(
      {super.key, required this.gridSize, required this.borderWidth});

  double gridSize;
  double borderWidth;

  @override
  Widget build(BuildContext context) => Container(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final int numColumns = (constraints.maxWidth / gridSize).ceil();
            final int numRows = (constraints.maxHeight / gridSize).ceil();
            return GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numColumns,
              ),
              itemCount: numColumns * numRows,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12, // 線の色
                      width: borderWidth, // 線の太さ
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
}
