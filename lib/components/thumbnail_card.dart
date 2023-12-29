import 'package:flutter/material.dart';
import 'package:xref/pages/canvas_page.dart';

class ThumbnailCard extends StatefulWidget {
  const ThumbnailCard({
    Key? key,
    required this.title,
    required this.thumbnailImage,
  }) : super(key: key);

  final String title;
  final ImageProvider thumbnailImage;

  @override
  State<ThumbnailCard> createState() => _ThumbnailCardState();
}

class _ThumbnailCardState extends State<ThumbnailCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: GestureDetector(
              child: Image(image: widget.thumbnailImage),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => const CanvasPage()),
                );
              },
            ),
          ),
          Center(
            child: FittedBox(
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
