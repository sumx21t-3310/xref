import 'package:flutter/material.dart';

class ThumbnailTile extends StatelessWidget {
  const ThumbnailTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: GridTile(
        child: Image(
          image: NetworkImage(
              "https://placehold.jp/808080/ffffff/150x150.png?text=no%20image"),
        ),
        footer: GridTileBar(),
      ),
    );
  }
}
