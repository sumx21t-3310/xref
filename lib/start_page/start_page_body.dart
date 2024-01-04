import 'package:flutter/material.dart';
import 'package:xref/start_page/thumbnail_card.dart';
import 'package:xref/start_page/thumbnail_data.dart';

class StartPageBody extends StatelessWidget {
  const StartPageBody({
    super.key,
    required this.thumbnails,
  });

  final List<ThumbnailData> thumbnails;

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      children: thumbnails
          .map(
            (element) => ThumbnailCard(
              title: element.title,
              thumbnailImage: element.image,
            ),
          )
          .toList(),
    );
  }
}
