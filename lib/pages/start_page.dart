import 'package:flutter/material.dart';
import 'package:xref/Pages/settings_page.dart';
import 'package:xref/components/thumbnail_card.dart';
import 'package:xref/lib/switch_platform.dart';

class ThumbnailData {
  ThumbnailData(this.title, this.image);

  final String title;
  final ImageProvider image;
}

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

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
    var image = NetworkImage("https://source.unsplash.com/random");
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
    return SwitchPlatform(
      titleBarColor: Theme.of(context).appBarTheme,
      innerContent: Scaffold(
        appBar: AppBar(
          title: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: deleteThumbnail,
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: addThumbnail,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: body(),
      ),
    );
  }
}
