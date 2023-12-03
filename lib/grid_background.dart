import 'package:flutter/material.dart';

Widget gridBackGround(double gridSize) {
  return LayoutBuilder(
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
                color: (Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white)
                    .withOpacity(0.3), // 線の色
                width: 0.5, // 線の太さ
              ),
            ),
          );
        },
      );
    },
  );
}
