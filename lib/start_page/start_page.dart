import 'package:flutter/material.dart';
import 'package:xref/start_page/start_page_app_bar.dart';
import 'package:xref/start_page/thumbnail_data.dart';

import 'thumbnail_card.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List<ThumbnailData> thumbnails = [];

  void deleteThumbnail() {
    if (thumbnails.isEmpty) return;

    setState(() {
      thumbnails.removeAt(0);
    });
  }

  void addThumbnail() {
    var image = const NetworkImage("https://source.unsplash.com/random");
    var number = thumbnails.length;
    setState(
      () => thumbnails.add(
        ThumbnailData(
          "untitled $number",
          image,
        ),
      ),
    );
  }

  Widget body() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StartPageAppBar(
        onDeleteTap: deleteThumbnail,
        onAddTap: addThumbnail,
      ),
      body: body(),
    );
  }
}
