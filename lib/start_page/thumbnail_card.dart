import 'package:flutter/material.dart';
import 'package:xref/application/save_data.dart';
import 'package:xref/canvas_page/views/canvas_page.dart';

class ThumbnailCard extends StatelessWidget {
  const ThumbnailCard({
    super.key,
    required this.saveData,
  });

  final SaveData saveData;

  @override
  Widget build(BuildContext context) {
    ImageProvider image =
        const NetworkImage("https://source.unsplash.com/random");

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: GestureDetector(
              child: Image(
                image: image,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => CanvasPage(
                      saveData: saveData,
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: FittedBox(
              child: Text(
                saveData.title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
